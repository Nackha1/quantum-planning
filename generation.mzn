include "utils.mzn";

int: n ::output;

array[1..n, 1..n] of var 0..1: M;

var int: det = determinant(M);
% constraint det = 1 \/ det = -1;
constraint det != 0;
constraint not is_unitary(M);

solve satisfy;