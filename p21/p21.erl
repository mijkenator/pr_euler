#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p20
% vim:syn=erlang

-mode(compile).

main(_) ->
    io:format("Answer: ~p ~n", [lists:sum(lists:flatten([fr(X) || X<-lists:seq(1,10000)]))]).

fr(X) ->
    D1 = lists:sum(d(X, 1,[])),
    case lists:sum(d(D1,1,[])) of
        X when X < D1 -> [X, D1];
        _             -> []
    end.

d(0, _, _)                    -> [];
d(N, M, A) when M > N div 2+1 -> A;
d(N, M, A) when N rem M =:= 0 -> d(N, M+1, [M|A]);
d(N, M, A)                    -> d(N, M+1, A).


