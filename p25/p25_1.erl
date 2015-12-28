#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p25
% vim:syn=erlang

-mode(compile).


main(_) ->
    io:format("Answer: ~p ~n", [test25()]).

test25() -> 
    Phi    = (math:sqrt(5) + 1) / 2,
    C      = math:log10(5) / 2,
    LogPhi = math:log10(Phi),
    t25i(1, C, LogPhi).

t25i(N, C, L) when N * L - C >= 999 -> N;
t25i(N, C, L) -> t25i(N+1, C, L).
