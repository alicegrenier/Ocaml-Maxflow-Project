open Graph

(* returns a new graph having the same nodes than gr, but no arc *)
let clone_nodes gr = n_fold gr (fun acu x -> new_node acu x) empty_graph

(* maps all arcs of gr by function f *)
let gmap _gr _f = assert false (*List.map (fun (_, arc_lst) -> (List.map (fun an_arc -> f an_arc) arc_lst)) gr*)

(* adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created *)
let add_arc (gr:int graph) (id1:id) (id2:id) (n:int) = 
  let arc_exists = find_arc gr id1 id2 in
  match arc_exists with
  | Some x -> new_arc gr {x with lbl = (x.lbl + n)}
  | None -> new_arc gr {src = id1 ; tgt = id2 ; lbl = n} 
