var 1..5: beef_total;
var 1..5: buns_total;
var 1..5: cheese_total;
var 1..5: onions_total;
var 1..5: pickles_total;
var 1..5: lettuce_total;
var 1..5: ketchup_total;
var 1..5: tomatoes_total;

int: beef;
int: buns;
int: cheese;
int: onions;
int: pickles;
int: lettuce;
int: ketchup;
int: tomatoes;

array[beef..tomatoes] of int: sodium;
array[beef..tomatoes] of int: fat;
array[beef..tomatoes] of int: calories;
array[beef..tomatoes] of int: cost;

var int: total_sodium = sodium[beef]*beef_total + sodium[buns]*buns_total + sodium[cheese]*cheese_total + sodium[onions]*onions_total + sodium[pickles]*pickles_total + sodium[lettuce]*lettuce_total + sodium[ketchup]*ketchup_total + sodium[tomatoes]*tomatoes_total;
var int: total_fat = fat[beef]*beef_total + fat[buns]*buns_total + fat[cheese]*cheese_total + fat[onions]*onions_total + fat[pickles]*pickles_total + fat[lettuce]*lettuce_total + fat[ketchup]*ketchup_total + fat[tomatoes]*tomatoes_total;
var int: total_calories = calories[beef]*beef_total + calories[buns]*buns_total + calories[cheese]*cheese_total + calories[onions]*onions_total + calories[pickles]*pickles_total + calories[lettuce]*lettuce_total + calories[ketchup]*ketchup_total + calories[tomatoes]*tomatoes_total;

var int: total_cost = cost[beef]*beef_total + cost[buns]*buns_total + cost[cheese]*cheese_total + cost[onions]*onions_total + cost[pickles]*pickles_total + cost[lettuce]*lettuce_total + cost[ketchup]*ketchup_total + cost[tomatoes]*tomatoes_total;

constraint total_sodium < 3000;
constraint total_fat < 150;
constraint total_calories < 3000;
constraint ketchup_total = lettuce_total;
constraint pickles_total = tomatoes_total;
constraint total_cost = 280;

/* solve maximize total_cost; */
solve satisfy;

output ["price = \(total_cost)\n",
        "patties = \(beef_total)\n",
        "buns = \(buns_total)\n",
        "cheese = \(cheese_total)\n",
        "onions = \(onions_total)\n",
        "pickles \(pickles_total)\n",
        "lettuce = \(lettuce_total)\n",
        "ketchup = \(ketchup_total)\n",
        "tomatoes = \(tomatoes_total)\n",
        "sodium = \(total_sodium)\n",
        "fat = \(total_fat)\n",
        "calories = \(total_calories)\n"
        ];
