# FinSc-Electromagnetism

[![Idris 2 Verification](https://img.shields.io/badge/Idris_2-0.8.0-blue.svg)](https://www.idris-lang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Layer 3c Discrete Exterior Calculus, Maxwell Equations & Gauge Flux Fields for Idris 2**

`FinSc-Electromagnetism` forms **Layer 3c** of the 10-layer constructive non-linear multiset science framework. It formalizes discrete exterior calculus (DEC), Maxwell field equations ($d F = 0$, $d \star F = J$), discrete Hodge star operators ($\star$), gauge transformation channels ($A \to A + d\phi$), and energy density tensors.

---

## 📦 Core Library Architecture & Modules

### 1. `EM.Calculus`
- **Discrete Exterior Calculus:** 0-form potentials, 1-form vector fields, 2-form Faraday field strength tensors ($F = d A$), and 3-form charge density distributions ($J$).
- **Exterior Derivative ($d$):** Exact coboundary operator satisfying $d^2 = 0$ at compile time.

### 2. `EM.Maxwell` & `EM.Flux`
- **Discrete Maxwell Equations:**
  - **Homogeneous Maxwell Equation:** $d F = 0$ (Gauss's law for magnetism & Faraday's law).
  - **Inhomogeneous Maxwell Equation:** $d \star F = J$ (Gauss's law & Ampère-Maxwell law).
- **Gauge Flux Channels:** Charge conservation channels (`EM.Flux`), divergence inspection (`divergence`), and discrete energy density tensors.

### 3. `EM.Hodge` & `EM.Gauge`
- **Discrete Hodge Star ($\star$):** Metric duality operator mapping $k$-forms to $(n-k)$-forms across discrete cell complexes.
- **Gauge Invariance:** Session-typed gauge transformation channels ($A \to A + d\phi$), proving local gauge invariance at compile time.

### 4. `Reflect.Auditor.EM`
- **Compile-Time Reflection Auditor:** `%macro` reflection auditor verifying gauge field conservation and Maxwell identities during compilation.

---

## 🚀 Building & Installing

```bash
idris2 --build FinSc-Electromagnetism.ipkg
idris2 --install FinSc-Electromagnetism.ipkg
```

---

## 🔬 Architectural Principles

- **Total Constructivism:** Enforces `%default total` across all discrete exterior calculus modules.
- **Topological Boundary Conservation:** $d^2 = 0$ enforcing exact charge conservation without numerical divergence artifacts.
- **Zero Floating-Point Drift:** Pure rational field calculations over discrete cell complexes.
