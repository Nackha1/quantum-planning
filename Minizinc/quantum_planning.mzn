include "utils.mzn";

int: n;
int: max_t;

array[1..n, 1..n] of 0..1: M;
array[1..n, 1..n, 0..max_t] of var 0..1: A;
array[1..2, 1..max_t] of var 0..n: plan;
var 0..max_t: steps;

constraint forall(i,j in 1..n)(A[i,j,0] = M[i,j]);
constraint forall(t in 1..max_t)(plan[1,t] != plan[2,t] \/ (plan[1,t] = 0 /\ plan[2,t] = 0));

constraint steps = min([t | t in 1..max_t where plan[1,t] = 0]) - 1;
constraint is_unitary(get_matrix_at(A, steps));

% Slower "compound" version
% constraint forall(i,j in 1..n, t in 1..max_t)(if plan[1,t] = i then A[i,j,t] = (A[i,j,t-1] + A[plan[2,t],j,t-1]) mod 2 else A[i,j,t] = A[i,j,t-1] endif);

% Faster "split" version
constraint forall(i,j in 1..n, t in 1..max_t)(plan[1,t] = i -> A[i,j,t] = (A[i,j,t-1] + A[plan[2,t],j,t-1]) mod 2);
constraint forall(i,j in 1..n, t in 1..max_t)(plan[1,t] != i -> A[i,j,t] = A[i,j,t-1]);

constraint forall(t in 0..max_t-1)(is_unitary(get_matrix_at(A, t)) -> (plan[1,t+1] = 0 /\ plan[2,t+1] = 0));

output ["M = \n" ++ show2d(M) ++ ";\n"];
output ["xor rows \(plan[1,t]) and \(plan[2,t])\n" ++ "A[\(t)] = \n" ++ show2d(get_matrix_at(A, t)) ++ ";\n" | t in 1..fix(steps)];
% output ["Final matrix in \(steps) steps = \n" ++ show2d(get_matrix_at(A, steps)) ++ ";\n" ++ "is unitary? \(is_unitary(get_matrix_at(A, steps)))\n"];
output ["Final matrix in \(steps) steps, is it unitary? \(is_unitary(get_matrix_at(A, steps)))\n"];
output ["Complete plan = \n" ++ show2d(plan) ++ ";\n"];
solve minimize steps;