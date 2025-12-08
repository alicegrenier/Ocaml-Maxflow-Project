open Graph
open Tools

type graph_path = id list

(********************************INJECT FLOW RESIDUAL********************************)

(* injects flow on the residual graph arcs for the given path*)
let rec inject_flow_residual residual_graph graph_path flow =

  match graph_path with
  | [] -> residual_graph
  | id_node1 :: id_node2 :: [] -> add_return_arc (add_arc residual_graph id_node1 id_node2 flow) id_node1 id_node2 flow
  | id_node3 :: id_node4 :: rest -> inject_flow_residual (add_return_arc (add_arc residual_graph id_node3 id_node4 flow) id_node3 id_node4 flow) (id_node4 :: rest) flow
  | _ :: [] -> residual_graph


(********************************INJECT FLOW CAPACITY********************************)

(* injects flow on the capacity graph arcs for the given path*)
let rec inject_flow_capacity capacity_graph graph_path flow =

  match graph_path with
  | [] -> capacity_graph
  | id_node1 :: id_node2 :: [] -> add_capacity capacity_graph id_node1 id_node2 flow
  | id_node3 :: id_node4 :: rest -> inject_flow_capacity (add_capacity capacity_graph id_node3 id_node4 flow) (id_node4 :: rest) flow
  | _ :: [] -> capacity_graph

(***********************************FIND PATH************************************)

let find_path _residual_graph _src _dst = None
  (*TO DO*)

(***********************************FIND FLOW************************************)
(* Find minimum flow for a given path *)

  let find_flow graph_path residual_graph =
    
    let rec loop graph_path acu =

      match graph_path with
      | [] -> acu
      | id_node1 :: id_node2 :: [] -> 
        begin
          match (find_arc residual_graph id_node1 id_node2) with
          | None -> acu
          | Some arc -> if arc.lbl > acu then arc.lbl else acu
        end

      | id_node3 :: id_node4 :: rest -> 
        begin
          match (find_arc residual_graph id_node3 id_node4) with
          | None -> acu
          | Some arc -> if arc.lbl > acu then loop (id_node4 :: rest) arc.lbl else loop (id_node4 :: rest) acu
        end

      | _ :: [] -> acu
    
      in loop graph_path 1000

(********************************COMPUTE MAX FLOW********************************)

let compute_max_flow gr src dest = 

  (*à partir du graphe de base, créer un graphe de flot 0*)
  let capacity_graph = create_capacity_graph gr in

  (*à partir du graphe de base, créer un graphe d'écart vide*)
  let residual_graph = create_residual_graph capacity_graph in

  (* créer un chemin initial vide, auquel on va progressivement ajouter des sommets *)
  let resulting_path = [] in

  (*en partant du node source, parcourir pour voir s'il existe un chemin --> fonction dédiée à rechercher un chemin*)
  (*Il faut que cette fonction cherche s'il existe des arcs et s'il reste du flot sur ces arcs*)
  (*Il faut ce soit le meilleur chemin en terme de flot (flot le plus élevé possible) *)

  let rec loop ... capacity_graph residual_graph resulting_path = (* tant qu'il existe un chemin --> on démarre avec resulting_path, mais avec quel chemin on itère ??*)

  (* à chaque itération, on regarde si on peut encore injecter du flot (ie : il existe un chemin améliorant) *)
  match (find_path capacity_graph src dest) with

    (*1) s'il n'y a pas/plus de chemin (None), on renvoie le chemin de l'itération précédente *)
    | None -> resulting_path (* le chemin, peut être vide *)

    (*2) s'il existe un chemin, on applique l'algo à ce chemin --> fonction dédiée à appliquer l'algo sur un chemin donné*)
    | Some (path, flow) -> let capacity_graph, residual_graph = inject_flow residual_graph path flow

in

  loop ... capacity_graph residual_graph resulting_path


(* répéter autant de fois que nécessaire jusqu'à obtenir un flot max *)