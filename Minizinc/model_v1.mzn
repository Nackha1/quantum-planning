include "globals.mzn";
include "utils.mzn";

% Constants
int: n;
int: max_t;

% Variables
array[1..n, 1..n] of 0..1: M;
array[1..n, 1..n, 0..max_t] of var 0..1: A;
array[1..2, 1..max_t] of var 0..n: plan;
var 0..max_t: steps;

% Initial configuration
constraint forall(i,j in 1..n)(A[i,j,0] = M[i,j]);

% Plan generation
constraint forall(t in 1..max_t)(plan[1,t] = 0 -> plan[2,t] = 0);
constraint forall(t in 1..max_t)(plan[1,t] != 0 -> plan[1,t] != plan[2,t]);

constraint forall(t in steps+1..max_t)(plan[1,t] = 0 /\ plan[2,t] = 0);
constraint forall(t in 1..max_t-1)(plan[1,t] = 0 -> plan[1,t+1] = 0);

% Final goal
% constraint forall(i,j in 1..n where i != j)(sum(k in 1..n)(A[i,k,steps] * A[i,k,steps]) = 1 /\ sum(k in 1..n)(A[i,k,steps] * A[j,k,steps]) = 0);

% Same as above, same speed
% constraint forall(i,j in 1..n where i != j)(sum(k in 1..n)(A[i,k,steps] * A[j,k,steps]) = 0);
% constraint forall(i in 1..n)(sum(k in 1..n)(A[i,k,steps] * A[i,k,steps]) = 1);

% Same as above, same speed
constraint is_unitary(get_matrix_at(A, steps));

% Evolution "split" version
% constraint forall(i,j in 1..n, t in 1..max_t)(plan[1,t] = i -> A[i,j,t] = (A[i,j,t-1] + A[plan[2,t],j,t-1]) mod 2);
% constraint forall(i,j in 1..n, t in 1..max_t)(plan[1,t] != i -> A[i,j,t] = A[i,j,t-1]);

% Evolution "compound" version
constraint forall(i,j in 1..n, t in 1..max_t)(if plan[1,t] = i then A[i,j,t] = (A[i,j,t-1] + A[plan[2,t],j,t-1]) mod 2 else A[i,j,t] = A[i,j,t-1] endif);

output ["M = \n" ++ show2d(M) ++ ";\n"];
output ["xor rows \(plan[1,t]) and \(plan[2,t])\n" ++ "A[\(t)] = \n" ++ show2d(get_matrix_at(A, t)) ++ ";\n" | t in 1..fix(steps)];
output ["Final matrix in \(steps) steps, is it unitary? \(is_unitary(get_matrix_at(A, steps)))\n"];
output ["Plan = \n" ++ show2d(plan) ++ ";\n"];
solve %:: int_search(plan, input_order, indomain_random)
      minimize steps;