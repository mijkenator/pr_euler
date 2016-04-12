#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p46
% vim:syn=erlang

-mode(compile).
-define(MAX, 10000).

main(_) -> 
    get_primes(?MAX),
    get_squares(?MAX),
    io:format("Answer ~p ~n", [t46(35)]).

t46(N) when N < ?MAX ->
    case is_prime(N) of
        true -> t46(N+2)
        ;_   -> 
                case is_goldbach(N, get("primes")) of
                    true -> t46(N+2)
                    ;_   -> N
                end
    end;
t46(N) -> {stop, N}.

is_goldbach(N, [H|T]) when N >= H ->
   case (N-H) rem 2 of
        0 ->
           case ets:lookup(squares, (N-H) div 2) of
                [] -> is_goldbach(N, T)
                ;_ -> true
           end;
        _ -> is_goldbach(N, T) 
    end;
is_goldbach(_, _) -> false.

is_prime(N) ->
    case ets:lookup(prim, N) of
        [] -> false
        ;_ -> true
    end.

get_squares(N) ->
    ets:new(squares, [public, named_table, {write_concurrency, true} ]),
    lists:foreach(fun(E)-> ets:insert(squares, {E*E,1}) end, lists:seq(1, N)).
%----------------------------------------------- prime generator from Project Euler 10 (version 5 ---------------------------)
get_primes(N) ->
    ets:new(comp, [public, named_table, {write_concurrency, true} ]),
    ets:new(prim, [public, named_table, {write_concurrency, true}]),
    composite_mc(N),
    primes_mc(N),
    lists:sort([P || {P,_} <-ets:tab2list(prim)]).

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

