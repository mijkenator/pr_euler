#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p3_1
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = i(2, 600851475143),
    io:format("Answer ~p ~n",[Answer]).

i(I, N) when I*I < N -> i(I+1, j(I, N));    
i(_, N) -> N.

j(I, N) when N rem I =:= 0 -> j(I, N div I);
j(_, N) -> N.
