# ⚡ Idris2-Electromagnetism

**Layer 3c Constructive Discrete Electromagnetism & Gauge Field Engine in [Idris 2](https://github.com/idris-lang/Idris2).**

[![Idris2](https://img.shields.io/badge/Idris2-Electromagnetism-yellow.svg)](https://github.com/idris-lang/Idris2)

---

## 🏛️ Overview

`Idris2-Electromagnetism` formalizes **Constructive Discrete Electromagnetism, $U(1)$ Gauge Invariance, and Discrete Exterior Calculus (DEC)** over exact integer multisets and fraction coordinates.

It builds directly on top of `Idris2-Multiset-Core`, `Idris2-Multiset-Transform`, `Idris2-Geometry`, and `Idris2-Physics`.

### Multiset Domain Mapping

```text
 FINITE SCIENCE EM ENTITY    MULTISET TYPE ALIAS          DISCRETE GEOMETRY BASIS
 ────────────────────────    ───────────────────          ───────────────────────
 Scalar Electric Potential   ElectricPotential            Vexel (0-Form Singletons)
 Vector Gauge Potential (A)  VectorPotential              Maxel (1-Form Edge Pixels)
 Magnetic Field Curvature    FaceCochain                  Maxel (2-Form Face Pixels)
 Charge Density (rho = d2F)  CellCochain                  Boxel (3-Form Volume Voxels)
 Poynting Energy Vector      Maxel                        Maxel Pixel Cross Products
```

---

## 📁 Module Map

| Module | Description |
|---|---|
| [EM.Potential](src/EM/Potential.idr) | `ElectricPotential` ($\Phi$), `VectorPotential` ($A$), vacuum initializers, and field superposition. |
| [EM.Calculus](src/EM/Calculus.idr) | Discrete exterior derivative coboundaries ($d_0, d_1, d_2$), electric field $E = -d_0 \Phi$, magnetic field $B = d_1 A$, and discrete Laplacian $\Delta \Phi$. |
| [EM.Gauge](src/EM/Gauge.idr) | $U(1)$ local gauge transformations ($A \to A + d_0 \chi$), Aharonov-Bohm holonomy, and compile-time proof of gauge invariance ($B(A + d_0 \chi) = B(A)$). |
| [EM.Flux](src/EM/Flux.idr) | Plaquette magnetic flux $B = \oint A \cdot dl$, Faraday induction $\mathcal{E} = -d\Phi_B/dt$, and Gauss's Law for Magnetism ($\nabla \cdot B = 0$). |
| [EM.Hodge](src/EM/Hodge.idr) | Combinatorial Hodge Star duality ($\star : C_k \to C_{3-k}$), star involution ($\star \star F = F$), and discrete Hodge field decomposition. |
| [EM.Maxwell](src/EM/Maxwell.idr) | Consolidated `MaxwellState`, discrete Poynting energy vector $S = E \times B$, energy density $u = \frac{1}{2}(E^2 + B^2)$, and Poynting conservation theorem. |
| [Reflect.Auditor.EM](src/Reflect/Auditor/EM.idr) | Compile-time `%macro` elaborator reflection proof auditors for all physical EM conservation laws. |

---

## 🛠️ Build & Verification

```bash
toolbox run -c fedora-toolbox-44 /var/home/justin/.local/bin/idris2 --build Idris2-Electromagnetism.ipkg
toolbox run -c fedora-toolbox-44 /var/home/justin/.local/bin/idris2 --install Idris2-Electromagnetism.ipkg
```

© Justin Kelly. All rights reserved.
