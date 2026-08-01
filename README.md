# ⚡ idris2-Electromagnetism

**Row 10 Gauge Field & Electromagnetism DSL in [Idris 2](https://github.com/idris-lang/Idris2).**

[![Idris2](https://img.shields.io/badge/Idris2-Electromagnetism-yellow.svg)](https://github.com/idris-lang/Idris2)

---

## 🏛️ Overview

`idris2-Electromagnetism` formalizes **Row 10 of the Global Finite Science Table: Electromagnetism & Discrete Gauge Theory**. 

It builds directly on top of `idris2-Substrate` (the Causal Graph & Discrete Multiset Calculus library) and `idris2-Chromogeometry` (Wildberger's RGB rational metric signatures).

### Multiset Domain Mapping

```
 FINITE SCIENCE EM ENTITY    MULTISET TYPE ALIAS          SUBSTRATE CONTEXT
 ────────────────────────    ───────────────────          ─────────────────
 Scalar Electric Potential   ElectricPotential            Vexel (0-Cochain)
 Vector Gauge Field (A_ij)   GaugeField                   Substrate (1-Cochain)
 Magnetic Flux (B)           PlaquetteFlux                Maxel Loop (2-Cell)
 Gauge Force Operator        MaxelOperator                Maxel Matrix Operator
```

---

## 📁 Module Map

| Module | Description |
|---|---|
| [EM.Potential](src/EM/Potential.idr) | `ElectricPotential` (0-cochain), `GaugeField` (1-cochain), and potential gradient maps. |
| [EM.Calculus](src/EM/Calculus.idr) | Discrete Maxwell divergence ($\text{div } E = \rho$) and Laplacian operators. |
| [EM.Gauge](src/EM/Gauge.idr) | `MaxelOperator`, `applyGaugeMaxel`, and compile-time gauge conservation. |
| [EM.Flux](src/EM/Flux.idr) | Plaquette flux $B = d_1 A$, gauge holonomy, and discrete phase twists. |
| [EM.Hodge](src/EM/Hodge.idr) | Orthogonal field decomposition into electrostatic gradient, magnetic curl, and harmonic states. |

---

## 📚 References

- **Norman J. Wildberger**: *Divine Proportions* and *Chromogeometry*.
- **Google DeepMind Antigravity Team**: Finite Science Architecture.

© Justin Kelly. All rights reserved.
