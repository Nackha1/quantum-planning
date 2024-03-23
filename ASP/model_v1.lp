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

% Matrix for unitary check
c(I,J,S) :- coord(I), coord(J), steps(L),
            S = #sum { V1 * V2, K : coord(K), val(V1), val(V2), a(I,K,V1,L), a(J,K,V2,L) }.

% Final goal
goal(X,Y) :- coord(X), coord(Y), c(X,Y,S), X != Y, S = 0.
goal(X,X) :- coord(X), c(X,X,S), S = 1.
:- coord(X), coord(Y), not goal(X,Y).

#minimize { L : steps(L) }.

% Output
% #show a/4.
#show xor/3.
#show steps/1.

% Debug
% #show affected/2.
% #show c/3.
% #show goal/2.