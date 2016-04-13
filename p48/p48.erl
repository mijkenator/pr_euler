#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p47
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = lists:foldl(fun(E,A)-> pow(E,E) + A end, 0, lists:seq(1,1000)) rem pow(10,10),
    io:format("Answer: ~p ~n", [Answer]).

pow(_, 0) -> 1;
pow(A, B) -> A*pow(A, B-1).
