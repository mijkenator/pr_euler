#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p4
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = lists:foldl(fun(A,B)-> A*B end, 1, filter(lists:seq(2,20))),
    io:format("Answer ~p ~n",[ Answer ]).

filter([])    -> [];
filter([H|T]) -> [H | filter([ divide(X,H) || X <- T])].

divide(A, B) when A rem B =:= 0 -> A div B;
divide(A, _) -> A.
