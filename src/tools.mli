open Graph

(* returns a new graph having the same nodes than gr, but no arc *)
val clone_nodes: 'a graph -> 'b graph

(* maps all arcs of gr by function f (transforms the labels on first graph to labels with the format of second graph)*)
val gmap: 'a graph -> ('a -> 'b) -> 'b graph

(* adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created *)
val add_arc: int graph -> id -> id -> int -> int graph

(* adds a return arc of the specified arc (src -> dst) to the graph with the specified value as label*)
val add_return_arc: int graph -> id -> id -> int -> int graph