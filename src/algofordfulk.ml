open Graph
open Tools
open Fordfulktools

type graph_path = id list

(********************************INJECT FLOW RESIDUAL********************************)

(* injects flow on the residual graph arcs for the given path*)
let rec inject_flow_residual residual_graph graph_path flow =

  match graph_path with
  | [] -> residual_graph
  | id_node1 :: id_node2 :: [] -> add_return_arc (add_arc residual_graph id_node1 id_node2 (-flow)) id_node1 id_node2 flow
  | id_node3 :: id_node4 :: rest -> inject_flow_residual (add_return_arc (add_arc residual_graph id_node3 id_node4 (-flow)) id_node3 id_node4 flow) (id_node4 :: rest) flow
  | _ :: [] -> residual_graph


(********************************INJECT FLOW CAPACITY********************************)

(* injects flow on the capacity graph arcs for the given path*)
let rec inject_flow_capacity capacity_graph graph_path flow =

  match graph_path with
  | []| [_]   -> capacity_graph
  | id_node1 :: id_node2 :: rest -> let new_graph = add_capacity capacity_graph id_node1 id_node2 flow in
  inject_flow_capacity new_graph (id_node2 :: rest) flow

(**********************************GET MIN FLOW**********************************)  

(* finds the minimum flow of a path on a residual graph *)
let rec get_min_flow residual_graph path =
  match path with
  | [] | [_] -> max_int
  | id_node1 :: id_node2 :: rest ->
      match find_arc residual_graph id_node1 id_node2 with
      | None -> 0
      | Some arc -> min arc.lbl (get_min_flow residual_graph (id_node2 :: rest))

(***********************************FIND PATH************************************)

(* finds a path from the given source to the given destination in the given graph *)
let find_path residual_graph src dst = 

  (* recursive loop for a depth first search (dfs) within the graph *)
  let rec dfs already_visited current_node =

    (* if the current node is the destination, then the search is over*)
    (* adds the current node to a list that is then returned as the path found *)
    if current_node = dst then Some [current_node]
    (* if the current node is an element of the list of already visited nodes, 
      then the search is over, there is no path *)
    else if List.mem current_node already_visited then None
    
    else 
      (* retrieves all the outgoing arcs of the current node *)
      let outgoing_arcs = out_arcs residual_graph current_node in

      (* recursive loop on the list of outgoing arcs *)
      let rec loop = function
       | [] -> None (* empty list of arcs, meaning no path found from this node *)
       | arc :: rest -> 
        (* checks that the arc has a remaining capacity, otherwise it cannot be used*)
        (* also checks that the target node of this arc has not already been visited *)
        if arc.lbl > 0 && not (List.mem arc.tgt already_visited) then
        
        (* if all requirements are met, recursive research on the next node, 
        by adding the current node to the list of nodes already visited *)
        match dfs (current_node :: already_visited) arc.tgt with
        (* destination found, the path is rebuilt by adding the current node to the list of nodes already visited *)
         | Some path -> Some (current_node :: path)
        (* this arc does not lead to the destination, then goes on to the next arc *)
         | None -> loop rest
    
        else loop rest  
  in
  loop outgoing_arcs
in
dfs [] src 

(********************************COMPUTE MAX FLOW********************************)

(* computes Ford-Fulkserson algorithm on a given graph and returns maximum flow found *)
let compute_max_flow gr src dest = 
  
  (* from given graph, creates the initial capacity graph, with a flow equal to zero on every arc *)
  (* creates the corresponding residual graph *)
  (* unique intialization of both graphs *)
  let initial_capacity_graph = create_capacity_graph gr in
  let initial_residual_graph = create_residual_graph initial_capacity_graph in 

  (* recursive loop that iterates as long as in improving path exists *)
  let rec loop capacity_graph residual_graph total_flow = 

    (* at each iteration, checks wether flow can still be injected, ie : if there is an improving path on the graph *)
    match find_path residual_graph src dest with

    (* find_path cannot compute an improving path, maximum flow has been reached *)
    | None -> total_flow 

    (* find_path computes an improving path *)
    | Some path -> 
      (* goes through the path to find the minimum flow value *)
        let flow = get_min_flow residual_graph path in
        (* updates the capacity graph by injecting the flow value found *)
        let new_capacity_graph = inject_flow_capacity capacity_graph path flow in
        (* updates the residual graph by injecting the flow value found *)
        let new_residual_graph = inject_flow_residual residual_graph path flow in

        (* call to the next loop with the updated capacity graph, residual graph and flow *)
        loop new_capacity_graph new_residual_graph (total_flow + flow)
  in
  loop initial_capacity_graph initial_residual_graph 0