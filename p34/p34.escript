#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p34
% vim:syn=erlang

-mode(compile).

main(_) ->
    io:format("Project euler P34. ~n", []),
    L = limit(),
    io:format("hight boundary is: ~p ~n", [L]),
    F = [fact(N)||N<-lists:seq(0,9)],
    io:format("factorial precalc ~p ~n",[F]),
    put(fact, F),
    io:format("in mem: ~p ~n", [get(fact)]),
    R = calc(10,L,0),
    io:format("Answer ~p ~n",[R]),
    ok.

limit() -> fact(9)*7.

fact(0) -> 1;
fact(N) -> N*fact(N-1).

is_ok(Num) ->
    Num =:= lists:sum([lists:nth(N+1,get(fact)) || N <- list_of_digs(Num)]).


calc(N, M, A) when N =< M ->
    case is_ok(N) of
        true -> calc(N+1,M,A+N)
        ;_   -> calc(N+1,M,A)
    end;
calc(_, _, A) -> A.

list_of_digs(Num) -> lod(Num, []).
lod(0, A) -> A;
lod(N, A) -> lod(N div 10, [N rem 10]++A).
