#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p31
% vim:syn=erlang

-mode(compile).

main(_) ->
    Coins  = [1, 2, 5, 10, 20, 50, 100, 200],
    Result = 200,  
    io:format("Answer ~p ~n", [t31(Coins, Result)]).

t31(_, 0)            -> 1;
t31([], _)           -> 0;
t31(_, N) when N < 0 -> 0;
t31([C|Cs], N)       -> t31(Cs, N) + t31([C|Cs], N-C).
