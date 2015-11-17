#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p4
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = lists:max([ p(X,X) || X <- lists:seq(999,100,-1)]),
    io:format("Answer ~p ~n",[ Answer ]).


p(X,Y)  when Y > 99  ->
    P = X*Y,
    case is_palindrome(P) of
        true -> P
        ;_   -> p(X,Y-1)
    end;
p(_,_) -> 0.

is_palindrome(N) -> S = integer_to_list(N), S =:= lists:reverse(S).

