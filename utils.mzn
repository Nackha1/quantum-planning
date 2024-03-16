function array[int,int] of var int: get_matrix_at(array[int,int,int] of var int: A, var int: time) =
  let { int: n = max(index_set_1of3(A)) } in
  array2d(1..n, 1..n, [A[i,j,time] | i,j in 1..n]);

function array[int,int] of var int: transpose(array[int,int] of var int: A) =
  let { int: n = max(index_set_1of2(A)) } in
  array2d(1..n, 1..n, [A[j,i] | i,j in 1..n]);

function array[int,int] of var int: matrix_mul(array[int,int] of var int: A, array[int,int] of var int: B) =
  let { int: n = max(index_set_1of2(A)) } in
  array2d(1..n, 1..n, [sum(k in 1..n)(A[i,k] * B[k,j]) | i,j in 1..n]);
  
function var int: determinant(array[int,int] of var int: A) =
  let { int: n = max(index_set_1of2(A)) } in
  if n = 1 then
    A[1,1]
  else
    sum(i,j in 1..n)((-1)^(i+j) * A[i,j] * determinant(sub_matrix(A, i, j)))
  endif;
  
function array[int,int] of var int: sub_matrix(array[int,int] of var int: A, int: row_ex, int: col_ex) =
  let { int: n = max(index_set_1of2(A)) } in
  array2d(1..(n-1), 1..(n-1), [A[i,j] | i,j in 1..n where i != row_ex /\ j != col_ex]);
  
% function array[int,int] of var int: xor_rows(array[int,int] of var int: A, int: first_row, int: second_row) =
%   let { int: n = max(index_set_1of2(A)) } in
%   array2d(1..n, 1..n, [if i = first_row then (A[i,j] + A[second_row,j]) mod 2 else A[i,j] endif | i,j in 1..n]);
  
predicate is_identity(array[int,int] of var int: A) =
  let { int: n = max(index_set_1of2(A)) } in
  forall(i,j in 1..n)(if i = j then A[i,j] = 1 else A[i,j] = 0 endif);
  
predicate is_unitary(array[int,int] of var int: A) =
  is_identity(matrix_mul(A, transpose(A)));