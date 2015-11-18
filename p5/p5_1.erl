#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p5_1
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = lists:foldl(fun(A, B) -> A * B div gcd(A, B) end,1,lists:seq(2,20)),
    io:format("Answer ~p ~n",[ Answer ]).

gcd(A, B) when B > 0 -> gcd(B, A rem B);
gcd(A, _) -> A.

