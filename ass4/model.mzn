include "globals.mzn";

int : del_add;
int : del_mul;
int : number_add;
int : number_mul;
int : n; % number of operations
int : max_cycles = n * max(del_add, del_mul);

set of int : last;
set of int : add;
set of int : mul;

array[1..n] of set of 1..n : dependencies;

var 1..number_mul : mul_dom;
var (number_mul + 1)..(number_mul + number_add) : add_dom;

% Start times
array[1..length(add)] of var 0..max_cycles : start_add;
array[1..length(mul)] of var 0..max_cycles : start_mul;
array[1..n] of var 0..max_cycles : start_all;

% Y
array[1..length(add)] of var 1..number_add : y_add;
array[1..length(mul)] of var number_add+1..number_mul+number_add : y_mul;
array[1..n] of var int : y_all;

% Durations
array[1..length(add)] of int : dur_add = [ del_add | i in 1..length(add) ];
array[1..length(mul)] of int : dur_mul = [ del_mul | i in 1..length(mul) ];
array[1..n] of int : dur_all = [ if i in add then del_add else del_mul endif | i in 1..n ];

% Heights
array[1..length(add)] of int : height_add = [ 1 | i in 1..length(add) ];
array[1..length(mul)] of int : height_mul = [ 1 | i in 1..length(mul) ];
array[1..n] of int : height_all = [ 1 | i in 1..n ];

% Keep small lists and big list in sync
constraint forall ( i in 1..length(add) ) (
  y_all[add[i]] = y_add[i] /\
  start_all[add[i]] = start_add[i] /\
  dur_all[add[i]] = del_add );
constraint forall ( i in 1..length(mul) ) (
  y_all[mul[i]] = y_mul[i] /\
  start_all[mul[i]] = start_mul[i] /\
  dur_all[mul[i]] = del_mul );

constraint cumulative(start_add, dur_add, height_add, number_add);
constraint cumulative(start_mul, dur_mul, height_mul, number_mul);

constraint diffn(start_all, y_all, dur_all, height_all);

constraint forall ( i in 1..n, j in dependencies[i] ) ( start_all[i]+dur_all[i] <= start_all[j] );

var 1..max_cycles : schedule_end;
constraint forall ( i in last ) ( start_all[i]+dur_all[i] <= schedule_end );

ann: search_ann = int_search(start_all, first_fail, indomain_min);
solve :: search_ann minimize schedule_end;

output [
    "Schedule end: \(schedule_end)\n",
    "Add domain: 1..\(number_add)\n",
    "\([i | i in add])\n\([i | i in y_add])\n",
    "Mul domain: \(1)..\(number_mul)\n",
    "\([i | i in mul])\n\([i-number_add | i in y_mul])\n",

  ];
