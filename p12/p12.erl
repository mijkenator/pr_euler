#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p9 -pz ./ -prime
% vim:syn=erlang

-mode(compile).

main(_) ->
    io:format("Answer: ~p ~n", [triangle(1,prime(500))]).


triangle(N, L) ->
    M = N * (N+1) div 2,
    case nod(M, L, []) of
        P when P =< 500 -> triangle(N+1, L);
        _               -> M
    end.

nod(_, [], D) -> lists:foldl(fun(E,A)-> A*(E+1) end,1,D);
nod(M, [H|T], D) when H =< M ->
    case dp(M,H,0) of
        0 -> nod(M, T, D);
        C -> nod(M, T, [C|D])
    end;
nod(_, _, D) -> lists:foldl(fun(E,A)-> A*(E+1) end,1,D).

dp(M,H,A) when H =< M, M rem H =:= 0 -> dp(M div H, H, A+1);
dp(_,_,A)                            -> A.

%------------------------------------- prime library from problem 10 

prime(N) ->    
    ets:new(comp, [public, named_table, {write_concurrency, true} ]),
    ets:new(prim, [public, named_table, {write_concurrency, true}]),
    composite_mc(N),
    primes_mc(N),
    lists:sort([X||{X,_}<- ets:tab2list(prim)]).

primes_mc(N) ->
    case erlang:system_info(schedulers) of
        1 -> primes(N);
        C -> launch_primes(lists:seq(1,C), C, N, N div C)
    end.
launch_primes([1|T], C, N, R) -> P = self(), spawn(fun()-> primes(2,R), P ! {ok, prm} end), launch_primes(T, C, N, R);
launch_primes([H|[]], C, N, R)-> P = self(), spawn(fun()-> primes(R*(H-1)+1,N), P ! {ok, prm} end), wait_primes(C);
launch_primes([H|T], C, N, R) -> P = self(), spawn(fun()-> primes(R*(H-1)+1,R*H), P ! {ok, prm} end), launch_primes(T, C, N, R).

wait_primes(0) -> ok;
wait_primes(C) ->
    receive
        {ok, prm} -> wait_primes(C-1)
    after 1000    -> wait_primes(C)
    end.

primes(N) -> primes(2, N).
primes(I,N) when I =< N ->
    case ets:lookup(comp, I) of
        [] -> ets:insert(prim, {I,1})
        ;_ -> ok
    end,
    primes(I+1, N);
primes(I,N) when I > N -> ok.


composite_mc(N) -> composite_mc(N,2,round(math:sqrt(N)),erlang:system_info(schedulers)).
composite_mc(N,I,M,C) when I =< M, C > 0 ->
    C1 = case ets:lookup(comp, I) of
        [] -> comp_i_mc(I*I, I, N), C-1
        ;_ -> C
    end,
    composite_mc(N,I+1,M,C1);
composite_mc(_,I,M,_) when I > M -> ok;
composite_mc(N,I,M,0) ->
    receive
        {ok, cim} -> composite_mc(N,I,M,1)
    after 1000    -> composite_mc(N,I,M,0)
    end.

comp_i_mc(J, I, N) -> 
    Parent = self(),
    spawn(fun() ->
        comp_i(J, I, N),
        Parent ! {ok, cim}
    end).

comp_i(J, I, N) when J =< N -> ets:insert(comp, {J, 1}), comp_i(J+I, I, N);
comp_i(J, _, N) when J > N -> ok.


