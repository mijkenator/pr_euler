#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p9
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = lists:foldl(fun(E,A)-> E+A end, 0, sieve(2000000)),
    io:format("Answer: ~p ~n", [Answer]).

sieve(N) -> [1] ++ sieve(lists:seq(2, N), N).

sieve([Head|L], N) when Head * 2 < N ->
    [Head] ++ sieve(L -- lists:seq(Head * 2, N, Head), N);
sieve([Head|L], _) -> [Head] ++ L.
