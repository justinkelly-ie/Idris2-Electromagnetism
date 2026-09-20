module EM.FieldStream

import Data.List
import Data.Fuel
import Math.OnSeq.FusedStream
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
