#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p31
% vim:syn=erlang

-mode(compile).

main(_) ->
    Coins  = [1, 2, 5, 10, 20, 50, 100, 200],
    Result = 200,  
    Answer = lists:sum(lists:flatten([f(Result, 0, subcoins(Coins, C), C) || C <- Coins])),
    io:format("Answer ~p ~n", [Answer]).

subcoins(Coins, C)                -> subcoins(Coins, C, []).
subcoins([], _, A)                -> lists:reverse(A);
subcoins([H|T], C, A) when H =< C -> subcoins(T, C, [H] ++ A);
subcoins([_|T], C, A)             -> subcoins(T, C, A).


f(Result, Ac, _, _) when Result =:= Ac -> 1;
f(Result, Ac, _, C) when Result =:= Ac + C -> 1;
f(Result, Ac, _, _) when Result <   Ac -> 0;
f(Result, Ac, Sc, C) -> [f(Result , Ac + C, subcoins(Sc, C1), C1) || C1 <- Sc].
