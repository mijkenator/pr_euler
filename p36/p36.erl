#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p36
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = lists:sum([X||X<-lists:seq(1,999999), isDPalindrome(X)]),
    io:format("Answer ~p ~n", [ Answer ]).

isDPalindrome(X) ->
    L = integer_to_list(X),
    case L == lists:reverse(L) of
        true ->
            B = integer_to_list(X,2),
            B == lists:reverse(B)
        ;_   -> false
    end.

