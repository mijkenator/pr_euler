#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p9
% vim:syn=erlang

-mode(compile).

main(_) ->
    {A,B,C} = erlang:timestamp(),
    random:seed(A,B,C),
    L = [random:uniform(10000)||_<-lists:seq(1,5000000)],
    %io:format("Merge sort list: ~p ~n", [L]),
    %io:format("Merge sort list: ~p ~n", [qs(L)]).
    {T,_L1} = timer:tc(fun()->qs(L) end),
    io:format("Done ~p ~n", [T/1000000]).
    %
qs([])    -> [];
qs([H|T]) ->
    qs([E||E<-T, E<H]) ++ [H] ++ qs([E||E<-T, H =< E]).
