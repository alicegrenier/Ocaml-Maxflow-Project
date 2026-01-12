open Graph

(* capacity is an abstract type : can only be manipulated in module fordfulktools 
with functions add_capacity, create_capacity_graph and create_residual_graph of the module *)
type capacity

(* adds n to the current flow of the arc between id1 and id2 on the capacity graph *)
val add_capacity: capacity graph -> id -> id -> int -> capacity graph

(* creates a capacity graph with label = current_flow/max_flow from the original graph *)
val create_capacity_graph: int graph -> capacity graph

(* creates a residual graph from the capacity graph *)
val create_residual_graph: capacity graph -> int graph