#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p2
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = lists:sum([X ||X <- fib([2,1]), X rem 2 =:= 0]),
    io:format("Answer ~p ~n",[Answer]).

fib([H|T]) when H >= 4000000 -> lists:reverse(T);    
fib([H1, H2| T]) -> fib([H1+H2, H1, H2|T]).
