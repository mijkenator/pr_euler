#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p30
% vim:syn=erlang

-mode(compile).

main(_) -> 
    Answer = lists:sum(lists:filter(fun(N)-> sump(N,10,0) == N end, lists:seq(2,6*p5(9)))),
    io:format("Answer ~p ~n", [Answer]).

p5(D) -> D*D*D*D*D.

sump(0,_,A) -> A;
sump(N,B,A) when N < B -> A+p5(N);
sump(N,B,A) -> sump(N div B, B, A + p5(N rem B)).

