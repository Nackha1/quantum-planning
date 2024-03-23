% Constants
time(1..max_t).
val(0). val(1).
coord(1..n).

% Initial state
a(X,Y,V,0) :- coord(X), coord(Y), val(V), m(X,Y,V).

% Non-deterministic choices
0 { xor(I,J,T) : coord(I), coord(J), I != J } 1 :- time(T).
0 { a(X,Y,V,T) : val(V) } 1 :- coord(X), coord(Y), time(T).

% Contiguous plan
:- time(T), time(T-1), xor(_,_,T), not xor(_,_,T-1).

% Evolution propagation
affected(I,T) :- coord(I), coord(J), time(T), xor(I,J,T).

a(X,Y,S,T) :-   coord(X), coord(Y), coord(Z), val(S), val(V1), val(V2), time(T), steps(L),
                affected(X,T), xor(X,Z,T), a(X,Y,V1,T-1), a(Z,Y,V2,T-1), S = (V1 + V2) \ 2, T <= L.
a(X,Y,V,T) :-   coord(X), coord(Y), val(V), time(T), steps(L),
                not affected(X,T), a(X,Y,V,T-1), T <= L.
:- coord(X), coord(Y), val(V), time(T), steps(L), a(X,Y,V,T), T > L.

% Plan length
steps(L) :- L = #count { T : coord(I), coord(J), time(T), xor(I,J,T) }.

% Final goal
row_goal(X) :- coord(X), steps(L), S = #sum { V, Y : coord(Y), val(V), a(X,Y,V,L) }, S = 1.
col_goal(Y) :- coord(Y), steps(L), S = #sum { V, X : coord(X), val(V), a(X,Y,V,L) }, S = 1.
:- coord(X), not row_goal(X).
:- coord(Y), not col_goal(Y).

#minimize { L : steps(L) }.

% Output
% #show a/4.
#show xor/3.
#show steps/1.

% Debug
% #show affected/2.
% #show row_goal/1.
% #show col_goal/1.