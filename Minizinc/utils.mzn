predicate is_identity(array[int,int] of var int: A) =
  let { int: n = max(index_set_1of2(A)) } in
  forall(i,j in 1..n where i != j)(A[i,i] = 1 /\ A[i,j] = 0);
  
predicate is_unitary(array[int,int] of var int: A) =
  is_identity(matrix_mul(A, transpose(A)));

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