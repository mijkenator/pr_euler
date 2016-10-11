#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p9
% vim:syn=erlang

-mode(compile).

main(_) ->
    {A,B,C} = erlang:timestamp(),
    random:seed(A,B,C),
    L = [random:uniform(10000)||_<-lists:seq(1,100000)],
    %io:format("Merge sort list: ~p ~n", [L]),
    %io:format("Merge sort list: ~p ~n", [m(L)]).
    m(L),
    io:format("Done").

m([L]) -> [L]; 
m(L)   ->
    {L1,L2} = lists:split(length(L) div 2, L),
    merge(m(L1), m(L2)).

merge(L1, L2)    -> merge(L1, L2, []).
merge([], L2, A) -> A++L2;
merge(L1, [], A) -> A++L1;
merge([H1|T1], [H2|T2], A) when H2>=H1 -> merge(T1, [H2|T2], A++[H1]);
merge([H1|T1], [H2|T2], A) when H1>H2  -> merge([H1|T1], T2, A++[H2]).

