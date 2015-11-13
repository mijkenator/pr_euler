#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p34
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = lists:sum([ X || X <- lists:seq(1,999),  X rem 5 =:= 0 orelse X rem 3 =:= 0]),
    io:format("Answer: ~p ~n", [Answer]).
