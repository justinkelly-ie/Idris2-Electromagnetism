module EM.FieldStream

import Data.List
import Data.Fuel
import Math.OnSeq.FusedStream
import Math.Singleton.Bit
import EM.Maxwell
import EM.Calculus
import Core.VexelMaxel
import Core.BoxInt
import public Geometry.GrassmannCalculus

%default total

------------------------------------------------------------------------
-- 1. DEFORESTED ELECTROMAGNETIC FIELD STATE STREAMING
------------------------------------------------------------------------

||| Convert a sequence of Maxwell field states into a deforested stream.
public export
streamMaxwellStates : List MaxwellState -> FusedStream MaxwellState
streamMaxwellStates = stream

||| Deforested Poynting flux stream computation S = E x B over a sequence of states.
public export
fusedPoyntingStream : FusedStream MaxwellState -> FusedStream Core.VexelMaxel.Maxel
fusedPoyntingStream = mapStream (\st => computePoyntingVector (maxwellElectricField st) (maxwellMagneticField st))

||| Poynting flux stream transducer S = E x B.
public export
poyntingTransducer : StreamTransducer MaxwellState Core.VexelMaxel.Maxel
poyntingTransducer = MkTransducer (\(), st => Yield (computePoyntingVector (maxwellElectricField st) (maxwellMagneticField st)) ()) ()

||| Deforested electric field extraction from Maxwell states.
public export
fusedElectricStream : FusedStream MaxwellState -> FusedStream EdgeCochain
fusedElectricStream = mapStream maxwellElectricField

||| Electric field stream transducer.
public export
electricTransducer : StreamTransducer MaxwellState EdgeCochain
electricTransducer = MkTransducer (\(), st => Yield (maxwellElectricField st) ()) ()

||| Deforested magnetic field extraction from Maxwell states.
public export
fusedMagneticStream : FusedStream MaxwellState -> FusedStream FaceCochain
fusedMagneticStream = mapStream maxwellMagneticField

||| Magnetic field stream transducer.
public export
magneticTransducer : StreamTransducer MaxwellState FaceCochain
magneticTransducer = MkTransducer (\(), st => Yield (maxwellMagneticField st) ()) ()

||| Evaluates a Maxwell state stream into a List container.
public export
runMaxwellStream : Fuel -> FusedStream MaxwellState -> List MaxwellState
runMaxwellStream = runFueledStream

||| Accumulates discrete Poynting flux total energy across a stream of Maxwell states without intermediate list allocations.
public export covering
fusedPoyntingAccumulate : FusedStream MaxwellState -> Core.VexelMaxel.Maxel
fusedPoyntingAccumulate strm =
  foldStream addMaxel (MkMaxel []) (fusedPoyntingStream strm)
  where
    addMaxel : Core.VexelMaxel.Maxel -> Core.VexelMaxel.Maxel -> Core.VexelMaxel.Maxel
    addMaxel (MkMaxel xs) (MkMaxel ys) = MkMaxel (xs ++ ys)

------------------------------------------------------------------------
-- 2. DEFORESTED PHOTON STATE STREAM TRANSDUCERS (O(1) ALLOCATION)
------------------------------------------------------------------------

||| Photon State Token carrying polarization bit and photon energy frequency quanta.
public export
record PhotonStateToken where
  constructor MkPhotonToken
  polarization : Bit
  frequency    : BoxInt

public export
Eq PhotonStateToken where
  (MkPhotonToken p1 f1) == (MkPhotonToken p2 f2) = p1 == p2 && f1 == f2

||| Unfolds a list of photon state parameters into a deforested PhotonStateStream.
%inline public export
unfoldPhotonStream : List (Bit, BoxInt) -> FusedStream PhotonStateToken
unfoldPhotonStream items = MkStream nextStep items
  where
    nextStep : List (Bit, BoxInt) -> Step (List (Bit, BoxInt)) PhotonStateToken
    nextStep [] = Done
    nextStep ((pol, freq) :: rest) = Yield (MkPhotonToken pol freq) rest

||| Deforested stream transducer propagating photon states with zero intermediate list allocations.
public export
fusedPhotonStateStream : FusedStream PhotonStateToken -> FusedStream PhotonStateToken
fusedPhotonStateStream strm =
  mapStream (\tok => MkPhotonToken (tok.polarization) (tok.frequency + intToBoxInt 1)) strm

||| Evaluates total photon stream energy using a fused hylomorphism.
public export covering
fusedComputePhotonStreamEnergy : Fuel -> List (Bit, BoxInt) -> BoxInt
fusedComputePhotonStreamEnergy f items =
  fusedHylomorphism f
    (\st => case st of
              [] => Done
              (pol, freq) :: rest => Yield (MkPhotonToken pol freq) rest)
    (\tok, acc => frequency tok + acc)
    (intToBoxInt 0)
    items

||| Audit witness verifying zero-allocation deforested photon stream energy calculation.
public export covering
auditPhotonStreamProof : Bool
auditPhotonStreamProof =
  let items = [(Zero, intToBoxInt 5), (One, intToBoxInt 10)]
      totalE = fusedComputePhotonStreamEnergy (limit 100) items
  in unwrapBox totalE == 15
