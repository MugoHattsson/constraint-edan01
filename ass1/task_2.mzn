include "globals.mzn";

int: n;
int: n_prefs;
array[1..n_prefs, 1..2] of 1..n: prefs;
array[1..n] of var 1..n: positions;
array[1..n_prefs] of var 1..n: pref_dists;

function var 1..n: distance(var 1..n: a, var 1..n: b) = abs(a - b);

constraint alldifferent(positions);
constraint positions[1] > positions[2];

constraint forall (i in 1..n_prefs) (pref_dists[i] = distance(positions[prefs[i, 1]], positions[prefs[i, 2]]));
var int: max_dist = max(pref_dists);

solve minimize max_dist;

output[ "\(positions)\n",
        "\(max_dist)\n"];
