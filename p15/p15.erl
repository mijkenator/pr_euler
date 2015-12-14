#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p15
% vim:syn=erlang

-mode(compile).

main(_) ->
    io:format("Answer: ~p ~n", [test15(20)]).

test15(1) -> 2;
test15(N) -> ( 4 * N -2 ) * test15(N-1) div N.

