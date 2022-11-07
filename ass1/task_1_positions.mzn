include "globals.mzn";

int: n;
int: n_prefs;
array[1..n_prefs, 1..2] of int: prefs;

array[1..n] of var 1..n: positions;

function var 1..n: distance(var 1..n: a, var 1..n: b) = abs(a - b);
function array[int] of var opt 1..n: get_prefs(var opt 1..n: person) = [ prefs[row, 2] | row in 1..n_prefs where prefs[row, 1] = person];
predicate is_pref(var opt 1..n: person_a, var opt 1..n: person_b) = person_b in get_prefs(person_a);

var int: value = sum([is_pref(i,j) | i,j in 1..n where distance(positions[i],positions[j]) = 1]);

constraint alldifferent(positions);
constraint positions[1] > positions[2];

solve maximize value;

output[ "\(positions)\n",
        "\(value)\n"];
