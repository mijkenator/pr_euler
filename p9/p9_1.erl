#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p9_1
% vim:syn=erlang

-mode(compile).
-define(N, 1000).

main(_) ->
    io:format("Answer: ~p ~n", [a(1)]).

a(X) when X < ?N ->
    case b(X,X) of
        false -> a(X+1);
        Ret   -> Ret
    end.

b(X,Y) when Y < ?N, X*X+Y*Y =:= (?N-X-Y)*(?N-X-Y) -> X*Y*(?N-X-Y);
b(X,Y) when Y < ?N -> b(X,Y+1);
b(_,_) -> false.

