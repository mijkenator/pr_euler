#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p2_1
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = fib(2,1,0),
    io:format("Answer ~p ~n",[Answer]).

fib(A,B,S) when A >= 4000000, B rem 2 =:= 0 -> B+S;
fib(A,_,S) when A >= 4000000  -> S;
fib(A,B,S) when B rem 2 =:= 0 -> fib(A+B, A, B+S);
fib(A,B,S) -> fib(A+B, A, S).
