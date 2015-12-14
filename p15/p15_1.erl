#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p15
% vim:syn=erlang

-mode(compile).

main(_) ->
    io:format("Answer: ~p ~n", [test15i(20)]).

test15i(N) -> fac(2*N) div (fac(N) * fac(N)).

fac(1) -> 1;
fac(N) -> N*fac(N-1).

