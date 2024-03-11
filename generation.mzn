include "utils.mzn";

int: n;

array[1..n, 1..n] of var 0..1: M;

constraint is_unitary(M);

solve satisfy;