#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p24
% vim:syn=erlang

-mode(compile).


main(_) ->
    io:format("Answer: ~p ~n", [test24()]).

test24() ->
    L = ["0","1","2","3","4","5","6","7","8","9"],
    lists:nth(1000000,perms(L)).

perms([]) -> [[]];
perms(L)  -> [[H|T] || H <- L, T <- perms(L--[H])].

