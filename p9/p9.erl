#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p9
% vim:syn=erlang

-mode(compile).

main(_) ->
    D = 1000,
    Answer = lists:last([ X*Y*(D-X-Y) || X <- lists:seq(1, D), Y <- lists:seq(1, D), X*X + Y*Y =:= (D-X-Y)*(D-X-Y)]),
    io:format("Answer: ~p ~n", [Answer]).

