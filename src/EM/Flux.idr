module EM.Flux

import Substrate.Core
import Math.Multiset
import Math.BoxInt

%default total

||| A Plaquette 2-Cell represented as a closed loop of 4 Geometry nodes.
public export
record Plaquette where
  constructor MkPlaquette
  n1 : Geometry
  n2 : Geometry
  n3 : Geometry
  n4 : Geometry

||| Computes the magnetic flux B = ∮ A · dl around a 4-node Plaquette loop.
public export
computePlaquetteFlux : Plaquette -> Substrate -> Integer
computePlaquetteFlux (MkPlaquette p1 p2 p3 p4) sub =
  let edges = multisetToList sub
      getWeight : Geometry -> Geometry -> Integer
      getWeight src tgt =
        case filter (\((s, t), _) => s == src && t == tgt) edges of
          ((_, w) :: _) => w
          []            => 0
  in getWeight p1 p2 + getWeight p2 p3 + getWeight p3 p4 + getWeight p4 p1
