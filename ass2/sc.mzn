include "globals.mzn";

int: graph_size;
int: start;
int: n_dests;
int: n_edges;
array[1..n_dests] of int: dest;
array[1..n_edges] of int: from;
array[1..n_edges] of int: to;
array[1..n_edges] of int: cost;

array[1..graph_size] of var int: graph;

array[1..graph_size] of set of 1..n_edges: neighbours = [
  { to[edge]   | edge in 1..n_edges where from[edge] = node } union 
  { from[edge] | edge in 1..n_edges where to[edge] = node} 
               | node in 1..graph_size];

/* constraint forall (i in 1..graph_size) (graph[i] in neighbours[i]); */
/* constraint graph[1] != 1; */
constraint graph[1] in neighbours[1];
constraint subcircuit(graph);

array[1..graph_size] of var bool : included = [i != graph[i] | i in 1..graph_size];
var 1..graph_size: count = sum(included);

solve maximize count;

output["\(neighbours)\n",
        "\(graph)"];
