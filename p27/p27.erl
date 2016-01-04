#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p27
% vim:syn=erlang

-mode(compile).

main(_) -> 
    io:format("Answer ~p ~n", [test27()]).

test27() ->
    P = get_primes(1001),
    put("primes", P),
    {_,A,B} = lists:last(lists:usort([t27(X,P,{0,0,0}) || X <- lists:seq(-1000, 1000)])),
    A*B.

t27(_,[], Ac)               -> Ac;
t27(A, [B|T], {N,_,_} = Ac) ->
    case {calc(0,A,B),calc(0,A,-B)} of
        {N1,N2} when N1 > N2, N1 > N -> t27(A, T, {N1, A, B});
        {N1,N2} when N2 > N1, N2 > N -> t27(A, T, {N2, A, B})
        ;_ -> t27(A, T, Ac)
    end.

calc(N, A, B) ->
    case is_prime(N*N + A*N + B) of
        true -> calc(N+1, A, B)
        ;_   -> N
    end.

is_prime(N) -> is_prime(N, 2).
is_prime(N, _) when N < 1000 -> lists:member(N, get("primes"));
is_prime(N, M) when M > N div 2   -> true;
is_prime(N, M) when N rem M =:= 0 -> false;
is_prime(N, M) -> is_prime(N, M + 1).

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
