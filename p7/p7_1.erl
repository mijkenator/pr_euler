#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p7_1
% vim:syn=erlang

-mode(compile).

main(_) ->
    N = 10001,
    Answer = lists:nth(N,erato(lists:seq(2,110000), 1, N)),
    io:format("Answer: ~p ~n", [Answer]).


erato(L, C, C)     -> L;
erato([H|T], N, C) -> [H| erato([ X || X <- T, X rem H =/= 0],N+1, C)].


