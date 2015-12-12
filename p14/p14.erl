#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p14
% vim:syn=erlang

-mode(compile).

main(_) ->
    io:format("Answer: ~p ~n", [test14()]).

test14()                          -> test14i(2, 1, 1).
test14i(N, C, L) when N < 1000000 ->
    case lseq(N, 0) of
        Length when Length > L -> test14i(N+1, N, Length);
        _                      -> test14i(N+1, C, L)
    end;
test14i(_, C, _)                  -> C.
    
lseq(1, N)                    -> N;
lseq(P, N) when P rem 2 =:= 0 -> lseq(P div 2, N+1);
lseq(P, N)                    -> lseq(P*3 + 1, N+1).
