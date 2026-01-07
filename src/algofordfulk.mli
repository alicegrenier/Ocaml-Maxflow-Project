open Graph
open Tools

type graph_path = id list

val inject_flow_residual: int graph -> graph_path -> int -> int graph

val inject_flow_capacity: capacity graph -> graph_path -> int -> capacity graph

val get_min_flow: int graph -> int list -> int

val find_path: int graph -> id -> id -> graph_path option

val find_flow: graph_path -> int graph -> int

val compute_max_flow: int graph -> id -> id -> int 