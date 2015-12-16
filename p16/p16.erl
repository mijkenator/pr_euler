#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p15
% vim:syn=erlang

-mode(compile).

main(_) ->
    io:format("Answer: ~p ~n", [test16(1000)]).

test16(N) ->
    lists:foldl(fun(E,A)-> A + list_to_integer([E]) end, 0, integer_to_list(round(math:pow(2,N)))).

