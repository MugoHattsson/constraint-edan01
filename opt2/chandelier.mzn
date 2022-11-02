include "globals.mzn";
var 1..9: a;
var 1..9: b;
var 1..9: c;
var 1..9: d;
var 1..9: e;
var 1..9: f;
var 1..9: g;
var 1..9: h;
var 1..9: i;

var int: g1 = 2*a - b - 2*c;
var int: g2 = 2*d + e - f;
var int: g3 = 2*g + h - 3*i;

var int: wg1 = a + b + c;
var int: wg2 = d + e + f;
var int: wg3 = g + h + i;

constraint alldifferent([a,b,c,d,e,f,g,h,i]);

constraint g1 = 0;
constraint g2 = 0;
constraint g3 = 0;

constraint 3*wg1 = 2*wg2 + 3*wg3;

solve satisfy;
