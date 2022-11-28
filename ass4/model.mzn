include "globals.mzn";

int : del_add;
int : del_mul;
int : number_add;
int : number_mul;
int : n; % number of operations
int : max_del = max(del_add, del_mul);
int : max_cycles = n * max_del;

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
array[1..length(add)] of var del_add..del_add : dur_add;
array[1..length(mul)] of var del_mul..del_mul : dur_mul;
array[1..n] of var 1..max(del_add, del_mul) : dur_all;

% Heights
array[1..length(add)] of var 1..1 : height_add;
array[1..length(mul)] of var 1..1 : height_mul;
array[1..n] of var 1..1 : height_all;

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
constraint forall (i in 1..n ) ( start_all[i]+dur_all[i] <= schedule_end);

ann: search_ann = int_search(start_all, first_fail, indomain_min);
solve :: search_ann minimize schedule_end;

output ["Schedule end: \(schedule_end)\n"];
