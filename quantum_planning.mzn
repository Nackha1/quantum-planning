include "utils.mzn";

int: n;

array[1..n, 1..n] of var 0..1: M;
array[1..n, 1..n] of var 0..1: path;
array[1..n, 1..n] of var 0..1: N;
var 0..n*(n-1): steps;

constraint forall(i in 1..n)(path[i,i] = 0);
constraint steps = sum(i,j in 1..n)(path[i,j]);
% constraint N = evolution(M, path);
% constraint forall(i,j in 1..n)(
%   forall(k in 1..n)(
%     if path[i,k] = 1 then
%       M[i,j] = (M[i,j] + M[k,j]) mod 2
%     else
%       M[i,j] = M[i,j]
%     endif
%   ));
constraint forall(i,j in 1..n)(path[i,j] = 1 -> N = xor_rows(M,i,j));
constraint is_unitary(N);

% constraint forall(i,j in 1..n)(path[i,j] = 1 -> M = xor_rows(M, i, j));
% constraint is_unitary(M);

% solve minimize steps;
% output ["M = \n", show2d(M), "\ndet = \(determinant(M))\n",
%         "transpose(M) = \n", show2d(transpose(M)), "\ndet = \(determinant(transpose(M)))\n",
%         "matrix_mul(M, transpose(M)) = \n", show2d(matrix_mul(M, transpose(M))), "\ndet = \(determinant(matrix_mul(M, transpose(M))))\n",
%         "is unitary? \(is_unitary(M))\n"
%         ];

% output ["\(M)"]
% output ["N = \n", show2d(N), "\n",
%         "N xor 1 and 2 = \n", show2d(xor_rows(N,1,2)), "\n",];
% output [show2d(sub_matrix(M, 2, 3))];
% output [show(is_identity(M)), show(transpose(transpose(M)) = M)];
% output [show2d(evolution(M, path))];