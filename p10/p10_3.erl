#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p9
% vim:syn=erlang
 
-mode(compile).

main(_) ->
    N = 20000000,
    ets:new(comp, [public, named_table]),
    ets:new(prim, [public, named_table]),
    composite(N),
    primes(N),
    Answer = lists:foldl(fun({E,_},A)-> E+A end, 0, ets:tab2list(prim)),
    io:format("Answer: ~p ~n", [Answer]).

primes(N) -> primes(2, N).
primes(I,N) when I =< N ->
    case ets:lookup(comp, I) of
        [] -> ets:insert(prim, {I,1})
        ;_ -> ok
    end,
    primes(I+1, N);
primes(I,N) when I > N -> ok.

composite(N) -> composite(N,2,round(math:sqrt(N))).
composite(N,I,M) when I =< M ->
    case ets:lookup(comp, I) of
        [] -> comp_i(I*I, I, N)
        ;_ -> ok
    end,
    composite(N,I+1,M);
composite(_,_,_) -> ok.

comp_i(J, I, N) when J =< N -> ets:insert(comp, {J, 1}), comp_i(J+I, I, N);
comp_i(J, _, N) when J > N -> ok.

