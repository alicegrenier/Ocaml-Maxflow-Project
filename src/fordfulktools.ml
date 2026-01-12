open Graph
open Tools

type capacity = 
{
  (* current flow on the arc *)
  current_flow: int ;

  (* max flow of the arc *)
  max_flow: int ;
}

(* adds n to the current flow of the arc between id1 and id2 on the capacity graph *)
let add_capacity gr id1 id2 n =
  let arc_exists = find_arc gr id1 id2 in
    match arc_exists with
    | None -> gr
    | Some x -> new_arc gr { src = x.src ; tgt = x.tgt ; lbl = {current_flow = (x.lbl.current_flow + n) ; max_flow = x.lbl.max_flow} }

(* creates a capacity graph with label = current_flow/max_flow from the original graph *)
(* using gmap to transform every label to a capacity record with 0 as current flow and the previous 
number on the label as maximul flow*)
let create_capacity_graph gr = 
  gmap gr (fun x -> {current_flow = 0 ; max_flow =  x})

(* creates a residual graph from the capacity graph *)
let create_residual_graph gr = 
  (* starting from the graph containing only the nodes*)
  let node_graph = clone_nodes gr in 
  (* Forward arc *)
  let add_forward = (fun gr1 arc -> new_arc gr1 {src = arc.src ; tgt = arc.tgt ; lbl = arc.lbl.max_flow - arc.lbl.current_flow }) in
  (* Backward arc *)
  let add_backward = (fun gr2 arc -> new_arc gr2 {src = arc.tgt ; tgt = arc.src ; lbl = arc.lbl.current_flow }) in
  (* function that adds both arcs to the graph *)
  let add_both gr3 arc = add_backward (add_forward gr3 arc) arc in
  (* going through all arcs in the original graph gr. For each arc, executes add_both while accumulating result, starting from node_graph. *)
  e_fold gr add_both node_graph