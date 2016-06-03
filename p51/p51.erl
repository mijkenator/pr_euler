#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p51
% vim:syn=erlang

-mode(compile).

main(_) ->
    get_primes(1000000),
    io:format("Answer ~p ~n",[ p51( lists:sort([K||{K,_}<-ets:tab2list(prim) ,K>100000,K<200000]) )]).

p51([N|T]) when N>100000 ->
    NS = integer_to_list(N),
    LD = lists:last(NS),
    case p51(NS, [LD], "0") of
        0 -> p51(T);
        A -> A 
    end;
p51([_|T]) -> p51(T).

p51(NS, "1", "1") -> p51(NS, "1", "2");
p51(NS, LD, R) ->
    case {c_count(NS,R), is_8_prime_family(NS,R), R} of
        {3, true,_} -> list_to_integer(NS);
        {_, _, "0"} -> p51(NS, LD, "1");
        {_, _, "1"} -> p51(NS, LD, "2");
        {_, _, "2"} -> 0
    end.

is_8_prime_family(Str, D) ->
    Fun = fun(N,A) ->
        case list_to_integer(re:replace(Str, D, integer_to_list(N), [global, {return, list}])) of
            NP when NP > 100000,NP < 999999 ->
                case is_prime(NP) of
                    true -> A + 1
                    ;_   -> A
                end
            ;_ -> A
        end
    end,
    Ret = lists:foldl(Fun, 0, lists:seq(0, 9)),
    Ret == 8.

c_count(Str, C) -> lists:foldl(fun(E,A) when [E]==C->A+1;(_,A)->A  end,0,Str).

%----------------------------------------------------------------------------------------------------------------------------

is_prime(N) ->
    case ets:lookup(prim, N) of
        [] -> false
        ;_ -> true
    end.
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

