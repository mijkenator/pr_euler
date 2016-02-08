#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p37
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = lists:sum(lists:sublist([P||P<-prime(1000000),
        P > 7,
        trunc_left_Prime( integer_to_list(P)), 
        trunc_right_Prime(integer_to_list(P))],1,11)),
    io:format("Answer ~p ~n", [ Answer ]).
 
trunc_left_Prime([_|T]) when length(T) > 1 ->
    case is_prime(list_to_integer(T)) of
        true  -> trunc_left_Prime(T);
        false -> false
    end;
trunc_left_Prime([_|H]) -> is_prime(list_to_integer(H)).

trunc_right_Prime(H) when length(H) > 1 ->
    {T,_} = lists:split(length(H)-1,H),
    case is_prime(list_to_integer(T)) of
        true  -> trunc_right_Prime(T);
        false -> false
    end;
trunc_right_Prime(H) -> is_prime(list_to_integer(H)).

%------------------------------------- prime library from problem 10------------
is_prime(X) ->
    case ets:lookup(prim, X) of
        [] -> false
        ;_ -> true
    end.

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



