time(1..max_t).
val(0). val(1).
coord(1..n).

a(X,Y,V,0) :- coord(X), coord(Y), val(V), m(X,Y,V).
% a(X,Y,V,T+1) :- coord(X), coord(Y), val(V), time(T), a(X,Y,V,T).
% steps(S) :- S = #min { T : time(T), xor(0,0,T) }.
% #minimize { S : steps(S) }.


1{ xor(I,J,T) : coord(I), coord(J), I != J }1 :- time(T).
% :- coord(I), time(T), xor(I,I,T).
% :- coord(I1), coord(J1), coord(I2), coord(J2), time(T), time(T+1), not xor(I1,J1,T), xor(I2,J2,T+1).

1 { a(X,Y,V,T) : val(V) } 1 :- coord(X), coord(Y), time(T).
% :- a(X,Y,V1,T), a(Z,Y,V2,T), xor(X,Z,T), a(X,Y,V,T+1), V != (V1 + V2) \ 2.
% :- coord(Z), a(X,Y,V1,T), a(X,Y,V2,T+1), not xor(X,Z,T), V1 != V2.

affected(I,T) :- coord(I), coord(J), time(T), xor(I,J,T).

a(X,Y,V,T+1) :- a(X,Y,V,T), not affected(X,T), time(T).
a(X,Y,S,T+1) :- a(X,Y,V1,T), a(Z,Y,V2,T), affected(X,T), xor(X,Z,T), S = (V1 + V2) \ 2, time(T).
% a(X,Y,S,T+1) :- coord(X), coord(Y), coord(Z), val(V1), val(V2), time(T), time(T+1), a(X,Y,V1,T), a(Z,Y,V2,T), xor(X,Z,T), S = (V1 + V2) \ 2.
% a(X,Y,V,T+1) :- coord(X), coord(Y), coord(Z), val(V), time(T), time(T+1), a(X,Y,V,T), not xor(X,Z,T).

% c(I,J,S) :- coord(I), coord(J), S = #sum { V1 * V2 : val(V1), val(V2), a(I,J,V1,max_t), a(J,I,V2,max_t)}.
% goal(X,Y) :- coord(X), coord(Y), c(X,Y,S), X != Y, S = 0.
% goal(X,X) :- coord(X), c(X,X,S), S = 1.
% :- coord(X), coord(Y), not goal(X,Y).
% #show c/3.
% #show goal/2.
#show xor/3.
#show a/4.