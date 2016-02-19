#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p39
% vim:syn=erlang

get_abc(A, P) ->
    B = (P*P - 2*P*A) / (2*P - 2*A),
    C = math:sqrt(A*A + B*B),
    case round(C) == C of
        true -> 1
        ;_   -> 0
    end.

count([], A)    -> [{P,_}|_] = lists:sort(fun({_,C},{_,D})-> C > D end, A), P;
count([H|T], A) -> count(T, [{H, proplists:get_value(H,A,0)+1}] ++ proplists:delete(H,A)).

t39() ->
    L = lists:filter(fun({_,0})-> false;(_)-> true end,
            lists:flatten([[{P,get_abc(A,P)} ||A<-lists:seq(1, P div 3)]||P<-lists:seq(12,1000)])),
    count([P||{P,_}<-L], []).


main(_) ->
    io:format("Answer: ~p ~n", [t39()]).
