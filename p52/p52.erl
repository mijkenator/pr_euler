#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p52
% vim:syn=erlang

-mode(compile).

main(_) -> io:format("Answer ~p ~n",[ p52(1) ]).

p52(N) -> 
    case answer(N*10, N*100 div 6 + 1) of
        {ok, Answer} -> Answer;
        _ -> p52(N*10)
    end.

answer(N, S) when N > S -> {error, next};
answer(N, S) ->
    NS = lists:sort(integer_to_list(N)),
    case a_(N, NS, 2) of
        true -> {ok, N}
        ;_   -> answer(N+1, S)
    end.

a_(_,_,7)    -> true;
a_(N, NS, I) ->
    case NS == lists:sort(integer_to_list(N*I)) of
        true -> a_(N, NS, I+1)
        ;_   -> false
    end.
