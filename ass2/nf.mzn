include "globals.mzn";

int: graph_size;
int: start;
int: n_dests;
int: n_edges;
array[1..n_dests] of int: dests;
array[1..n_edges] of int: from;
array[1..n_edges] of int: to;
array[1..n_edges] of int: cost;

array[1..n_edges, 1..2] of int: arcs = array2d(1..n_edges, 1..2, [
  if col == 1 then from[row] 
  else to[row] endif 
  | row in 1..n_edges, col in 1..2] );

array[1..graph_size] of int: balances = [ 
  if node == start then n_dests 
  elseif exists(dest in dests)(node == dest) then -1 
  else 0 endif
  | node in 1..graph_size];

array[1..n_edges] of var -n_dests..n_dests: flows;

var int: path_cost = sum([cost[edge] | edge in 1..n_edges where flows[edge] != 0]);

constraint network_flow(arcs, balances, flows);

solve minimize path_cost;

var set of int: path_edges = {edge | edge in 1..n_edges where flows[edge] != 0};
var set of int: path_nodes = { from[edge] | edge in path_edges} union { to[edge] | edge in path_edges};
array[int] of var opt set of int: paths = [ {from[edge], to[edge]} | edge in path_edges ];

output["Path cost: \(path_cost)\n",
       "\(flows)\n",
       "\(path_edges)\n",
       "\(paths)"];
