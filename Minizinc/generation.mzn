include "utils.mzn";

int: n ::output;

array[1..n, 1..n] of var 0..1: M;

var int: det = determinant(M);
% constraint det = 1 \/ det = -1;
constraint det != 0;
constraint is_unitary(M);
% constraint forall(i,j in 1..n where i != j)(sum(k in 1..n)(M[i,k] * M[i,k]) = 1 /\ sum(k in 1..n)(M[i,k] * M[j,k]) = 0);

solve satisfy;
% output [];
% output [show(determinant(fix(M)))];