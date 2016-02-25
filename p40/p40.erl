#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p40
% vim:syn=erlang

main(_) ->
    L = [1,10,100,1000,10000,100000,1000000],
    M = gb(L, [0]),
    Answer = lists:foldl(fun(E,A)-> E*A end, 1,
        lists:map(fun(X)-> dm(X,M) end, L)),
    io:format("Answer: ~p ~n", [Answer]).

gb([], [_|A]) -> A;
gb([H|T], A)  ->
    Len = length(integer_to_list(H)),
    gb(T, A ++ [lists:last(A) + 9 * pow(10, Len-1) * Len]).

pow(X,Y)   -> pow(X,Y,1).
pow(_,0,A) -> A;
pow(X,Y,A) -> pow(X,Y-1,A*X).

dm(1, _) -> 1;
dm(N, L) ->
    {Ln, Start} = lse(N, L),
    D = (N - Start) div Ln + pow(10, Ln-1),
    list_to_integer([lists:nth((N-Start) rem Ln, integer_to_list(D))]).

lse(N,[H|T])     -> lse(N,T,H,1).
lse(N,[H|_],P,I) when H > N -> {I+1, P};
lse(N,[H|T],_,I) -> lse(N,T,H,I+1).
