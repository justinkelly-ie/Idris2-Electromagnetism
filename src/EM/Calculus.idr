module EM.Calculus

import Substrate.Core
import Substrate.Difference
import Substrate.Divergence
import Substrate.Laplacian
import EM.Potential

%default total

||| Evaluates discrete electric field divergence ∇ · E = ρ across nodes.
public export
computeElectricDivergence : GaugeField -> Vexel
computeElectricDivergence gaugeField = applyDivergenceMap gaugeField

||| Evaluates the discrete Laplacian ΔΦ over integer box weights.
public export
computePotentialLaplacian : ElectricPotential -> Substrate -> Vexel
computePotentialLaplacian phi sub = multisetLaplacian phi sub
