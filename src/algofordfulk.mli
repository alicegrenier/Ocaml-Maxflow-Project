open Graph
open Fordfulktools

(* A path is a list of identifiers of nodes *)
type graph_path = id list

(* injects flow on the residual graph's arcs for the given path*)
val inject_flow_residual: int graph -> graph_path -> int -> int graph

(* injects flow on the capacity graph's arcs for the given path*)
val inject_flow_capacity: capacity graph -> graph_path -> int -> capacity graph

(* finds the minimum flow on given a path on a residual graph *)
val get_min_flow: int graph -> int list -> int

(* finds a path from the given source to the given destination in the given graph *)
val find_path: int graph -> id -> id -> graph_path option

(* computes Ford-Fulkserson algorithm on a given graph and returns maximum flow found *)
val compute_max_flow: int graph -> id -> id -> int 