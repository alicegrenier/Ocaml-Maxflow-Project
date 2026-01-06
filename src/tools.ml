open Graph

type capacity = 
{
  (* current flow on the arc *)
  current_flow: int ;

  (* max flow of the arc *)
  max_flow: int ;
}

(* returns a new graph having the same nodes than gr, but no arc *)
let clone_nodes gr = n_fold gr (fun acu x -> new_node acu x) empty_graph

(* maps all arcs of gr by function f *)
let gmap gr f = 
  let base = clone_nodes gr in
  let f2 = (fun gr2 arc -> new_arc gr2 {arc with lbl = f arc.lbl}) in 
  e_fold gr f2 base


(* adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created *)
let add_arc gr id1 id2 n = 
  let arc_exists = find_arc gr id1 id2 in
  match arc_exists with
  | Some x -> new_arc gr {x with lbl = (x.lbl + n)}
  | None -> new_arc gr {src = id1 ; tgt = id2 ; lbl = n} 

  (* adds n to the capacity of the arc between id1 and id2*)
let add_capacity gr id1 id2 n =
  let arc_exists = find_arc gr id1 id2 in
  match arc_exists with
  | None -> gr
  | Some x -> new_arc gr { src = x.src ; tgt = x.tgt ; lbl = {current_flow = (x.lbl.current_flow + n) ; max_flow = x.lbl.max_flow} }
  

  (* adds a return arc to the specified arc (src -> dst) with the specified value as label*)
  let add_return_arc gr src dst lbl = add_arc gr dst src lbl

  (* creates a capacity graph with label = current_flow/max_flow from the original graph*)
  let create_capacity_graph gr = 
    gmap gr (fun x -> {current_flow = 0 ; max_flow =  x})

  (* creates a residual graph from the capacity graph*)
  let create_residual_graph gr = 
    let node_graph = clone_nodes gr in 
    (* Forward arc *)
    let add_forward = (fun gr1 arc -> new_arc gr1 {src = arc.src ; tgt = arc.tgt ; lbl = arc.lbl.max_flow }) in
    (* Backward arc *)
    let add_backward = (fun gr2 arc -> new_arc gr2 {src = arc.tgt ; tgt = arc.src ; lbl = arc.lbl.current_flow }) in
    let add_both gr3 arc = add_backward (add_forward gr3 arc) arc in
    e_fold gr add_both node_graph


(*
  connected(x, y).
  connected(z, d).

  has_path(Orig, Dest) :- connect(Orig, Dest)
  has_path(Orig, Dest) :- connect(Orig, Inter), has_path(Inter, Dest).


  type graph_path = id list
  val find_path : int graph -> id -> id -> graph_path option
  *)