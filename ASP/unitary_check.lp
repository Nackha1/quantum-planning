val(0). val(1).
coord(1..n).

c(I,J,S) :- coord(I), coord(J),
            S = #sum { V1 * V2 : coord(I), coord(J), coord(K), val(V1), val(V2), m(I,K,V1), m(J,K,V2)}.
#show c/3.

% % Final goal
goal(X,Y) :- coord(X), coord(Y), c(X,Y,S), X != Y, S = 0.
goal(X,X) :- coord(X), c(X,X,S), S = 1.
:- coord(X), coord(Y), not goal(X,Y).
% #show goal/2.