open Graph

(*capacity est un type abstrait : ne peux être manipulé directement que dans le module fordfulktools
 avec les fonctions add_capacity, create_capacity_graph et create_residual_graph
 Si on voulait pouvoir afficher le graphe de capacité dans ftest, il faudrait ajouter une fonction capacity_to_string
 car on ne peut plus lire les champs du type capacity en dehors du module*)
type capacity

val add_capacity: capacity graph -> id -> id -> int -> capacity graph

val create_capacity_graph: int graph -> capacity graph

val create_residual_graph: capacity graph -> int graph