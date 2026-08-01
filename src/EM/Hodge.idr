module EM.Hodge

import Substrate.Core
import Substrate.Hodge
import EM.Potential

%default total

||| Decomposes an electromagnetic state vector into Harmonic (vacuum),
||| Electrostatic Gradient, and Magnetic Curl fields.
public export
decomposeEMField : Vexel -> Substrate -> HodgeComponents
decomposeEMField field sub = hodgeDecompose field sub
