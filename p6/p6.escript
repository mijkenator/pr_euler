#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p34
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = qs(),
    io:format("Answer: ~p ~n", [Answer]).

qs() -> qsi(1,{0,0}).
qsi(101,{A,B}) -> A*A - B;
qsi(N,{A,B})   -> qsi(N+1, {A+N, B + N*N}). 

