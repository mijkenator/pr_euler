#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p9
% vim:syn=erlang

-mode(compile).

main(_) ->
    %D = 1000,
    %Answer = lists:last([ X*Y*(D-X-Y) || X <- lists:seq(1, D), Y <- lists:seq(1, D), X*X + Y*Y =:= (D-X-Y)*(D-X-Y)]),
    Answer = a(1),
    io:format("Answer: ~p ~n", [Answer]).

a(X) when X < 1000 ->
    case b(X,X) of
        false -> a(X+1);
        Ret   -> Ret
    end.

b(X,Y) when Y < 1000, X*X+Y*Y =:= (1000-X-Y)*(1000-X-Y) -> X*Y*(1000-X-Y);
b(X,Y) when Y < 1000 -> b(X,Y+1);
b(_,_) -> false.

