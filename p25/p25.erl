#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p25
% vim:syn=erlang

-mode(compile).


main(_) ->
    io:format("Answer: ~p ~n", [test25()]).

test25()     -> fib(1,2,2).
fib(A,B,N)   ->
    case length(integer_to_list(A)) of
        1000 -> N;
        _    -> fib(B, A+B,N+1)
    end.

