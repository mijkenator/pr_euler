#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p9_1
% vim:syn=erlang

-mode(compile).

main(_) ->
    io:format("Answer: ~p ~n", [a(1)]).

a(X) when X < 1000 ->
    case b(X,X) of
        false -> a(X+1);
        Ret   -> Ret
    end.

b(X,Y) when Y < 1000, X*X+Y*Y =:= (1000-X-Y)*(1000-X-Y) -> X*Y*(1000-X-Y);
b(X,Y) when Y < 1000 -> b(X,Y+1);
b(_,_) -> false.

