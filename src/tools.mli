open Graph

type capacity = 
{
  (* current flow on the arc *)
  current_flow: int ;

  (* max flow of the arc *)
  max_flow: int ;
}

val clone_nodes: 'a graph -> 'b graph
val gmap: 'a graph -> ('a -> 'b) -> 'b graph
val add_arc: int graph -> id -> id -> int -> int graph

val add_return_arc: int graph -> id -> id -> int -> int graph

val add_capacity: capacity graph -> id -> id -> int -> capacity graph

val create_capacity_graph: int graph -> capacity graph

val create_residual_graph: capacity graph -> int graph