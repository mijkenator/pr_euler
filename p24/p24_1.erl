#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p24
% vim:syn=erlang

-mode(compile).


main(_) ->
    io:format("Answer: ~p ~n", [test24()]).

test24() ->
    L = ["0","1","2","3","4","5","6","7","8","9"],
    lists:nth(1000000,perm(L)).

perm([]) -> [[]];
perm(L)  -> zipper(L, [], []).
 
zipper([], _, Acc)    -> lists:reverse(Acc);
zipper([H|T], R, Acc) -> prepend(H, perm(lists:reverse(R, T)), T, [H|R], Acc).
 
prepend(_, [], T, R, Acc)      -> zipper(T, R, Acc); 
prepend(X, [H|T], ZT, ZR, Acc) -> prepend(X, T, ZT, ZR, [[X|H]|Acc]).

