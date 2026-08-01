module EM.Potential

import Substrate.Core
import Substrate.Difference

%default total

||| A 0-Cochain: Electric Potential Field mapped over Node Singletons.
public export
0 ElectricPotential : Type
ElectricPotential = Vexel

||| A 1-Cochain: Gauge Vector Field mapped over Directed Edge Pixels.
public export
0 GaugeField : Type
GaugeField = Substrate

||| Computes the Gauge Vector Field A_ij = Φ_j - Φ_i via multiset difference map d₀.
public export
computeGaugeField : ElectricPotential -> Substrate -> GaugeField
computeGaugeField phi sub = applyDifferenceMap phi sub
