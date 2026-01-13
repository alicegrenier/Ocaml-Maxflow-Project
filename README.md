This project is an implementation of the Ford-Fulkerson algorithm to find the maximum flow on a graph.

## Project structure

Our code is organized as follows :

* **`src/algofordfulk.ml`** : Main module where the loop for the concrete algorithm computation is implemented.
* **`src/fordfulktools.ml`** : Module used to handle capacity type and create graphs (residual and capacity). Defines the abstract capacity type.
* **`src/tools.ml`** : Tools module used to handle basic operations on any type of graph.
* **`src/ftest.ml`** : Testing module for the project.
* **`src/graph.ml` & `src/gfile.ml`** : Initial libraries to manipulate graphs and files.

A [`Makefile`](Makefile) provides some useful commands:

 - `make build` to compile. This creates an `ftest.exe` executable
 - `make demo` to run the `ftest` program with some arguments
 - `make format` to indent the entire project
 - `make edit` to open the project in VSCode
 - `make clean` to remove build artifacts

## Utilization

For testing purposes, use ftest by running 'make demo' with four arguments that can be changed in the Makefile.

* **`src`** : Identifier of the source node for the Ford-Fulkerson algorithm.
* **`dst`** : Identifier of the sink node for the Ford-Fulkerson algorithm.
* **`graph`** : Source text file for the initial graph given to the algorithm to compute the max flow.
* **`outfile`** : File in which results are written.

Authors : Alice Grenier grenie@insa-toulouse.fr - Claire Alix cali@insa-toulouse.fr




