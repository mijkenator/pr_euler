#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p9 +B
% vim:syn=erlang

-mode(compile).

main(_) ->
    {A,B,C} = erlang:timestamp(),
    random:seed(A,B,C),
    L = [random:uniform(10000)||_<-lists:seq(1,5000000)],
    %io:format("Merge sort list: ~p ~n", [L]),
    %io:format("Merge sort list: ~p ~n", [m(L)]).
    M = m(L),
    io:format("Done ~p", [M]).

m([L]) -> [L]; 
m(L)   ->
    {L1,L2} = lists:split(length(L) div 2, L),
    lists:merge(m(L1), m(L2)).


