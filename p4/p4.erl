#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p4
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = lists:max([ X*Y || X <- lists:seq(999,100,-1), Y <- lists:seq(999,100,-1), is_palindrome(X*Y)]),
    io:format("Answer ~p ~n",[ Answer ]).


is_palindrome(N) -> S = integer_to_list(N), S =:= lists:reverse(S).
