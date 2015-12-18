#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p20
% vim:syn=erlang

-mode(compile).

main(_) ->
    io:format("Answer: ~p ~n", [lists:sum(lists:flatten([fr(X) || X<-lists:seq(1,10000)]))]).

fr(X) ->
    D1 = d(X),
    case d(D1) of
        X when X < D1 -> [X, D1];
        _             -> []
    end.

d(0) -> 0;
d(N) -> lists:sum([X||X<-lists:seq(1,N div 2 + 1), N rem X =:= 0]).



