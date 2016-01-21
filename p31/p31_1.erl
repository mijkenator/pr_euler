#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p31
% vim:syn=erlang

-mode(compile).

main(_) ->
    Coins  = [1, 2, 5, 10, 20, 50, 100, 200],
    Result = 200,  
    Answer = lists:last(t(Coins, [1] ++ [0 || _ <- lists:seq(1, Result)], Result)),
    io:format("Answer ~p ~n", [Answer]).

t([], L, _)            -> L;
t([Coin|T], L, Result) ->
   t(T, f(lists:sublist(L, 1, Coin), Coin, Coin, Result, L), Result).

f(L, E, Coin, R, L1) when E =:= R ->
    L ++ [lists:nth(E + 1, L1) + lists:nth(E - Coin + 1, L)];
f(L, E, Coin, R, L1)              ->
    f(L ++ [lists:nth(E + 1, L1) + lists:nth(E - Coin + 1, L)], E + 1, Coin, R, L1).
