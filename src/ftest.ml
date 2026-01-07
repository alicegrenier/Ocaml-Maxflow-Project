open Gfile
open Tools
open Graph
open Algofordfulk
    
let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and source = int_of_string Sys.argv.(2)
  and sink = int_of_string Sys.argv.(3)
  in


  (*(*------------------------------INITIAL TEST--------------------------------------------*)
  let graph = from_file infile in 

  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph in

  ()*)

  (*(* ------------------------------ TEST CLONE_NODES --------------------------------- *)
  (* Open file *)
  let graph = from_file infile in 
  let clone_graph = clone_nodes graph in


  (* Rewrite the graph that has been read. *)
  let () = write_file outfile clone_graph in

  ()*)

  (* ----------------------------- TEST GMAP AND ADD_ARC ------------------------------ *)

  (* Open file *)
  (*let graph = from_file infile in 
  let g : int graph = gmap graph (fun x -> int_of_string x) in
  let add_graph = (add_arc g 0 3 3) in


  (* Rewrite the graph that has been read. *)
  let path_graph = gmap add_graph (fun x -> string_of_int x) in
  let () = write_file outfile path_graph in

  ()*)

  (* ----------------------------------TEST DOT FILE -----------------------------------*)

  (*let graph = from_file infile in 
  
  (* Rewrite the graph that has been read. *)
  let () = export outfile graph in

  ()*)

  (* ----------------------------------TEST RESIDUAL GRAPH -----------------------------------*)

(* Open file *)
  (*let graph = from_file infile in 
  let g : int graph = gmap graph (fun x -> int_of_string x) in
  let cap_graph = create_capacity_graph g in
  let res_graph = create_residual_graph cap_graph in


  (* Rewrite the graph that has been read. *)
  let path_graph = gmap res_graph (fun x -> string_of_int x) in
  let () = write_file outfile path_graph in

  let () = export outfile path_graph in

  ()*)

  (* ----------------------------------TEST ALL -----------------------------------*)
  (* Open file *)
  let graph = from_file infile in 
  let g : int graph = gmap graph (fun x -> int_of_string x) in
  let max_flow = compute_max_flow g source sink in

  (* Write the result that has been computed. *)
  let () = write_flow_in_file max_flow outfile in

  ()