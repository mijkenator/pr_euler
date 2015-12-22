#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p23
% vim:syn=erlang

-mode(compile).


main(_) ->
    io:format("Answer: ~p ~n", [test23()]).

test23() ->
    Fn = fun(X) ->
        case lists:sum(d(X)) of
            D when D > X -> true;
            _            -> false
        end
    end,
    Izb = lists:filter(Fn, lists:seq(1,28123)),
    ets:new(abd, [public, named_table]),
    lists:foreach(fun(E)-> ets:insert(abd,{E,1}) end, Izb),
    lists:sum(lists:filter(fun(X) -> an(X, Izb) end, lists:seq(1,28123))). 


d(0) -> [];
d(1) -> [];
d(N) -> lists:sort(divisors(1, N)).

divisors(1, N) -> [1|divisors(2,N,math:sqrt(N))].

divisors(K,_,Q) when K > Q -> [];
divisors(K,N,_) when N rem K =/= 0 -> divisors(K+1,N,math:sqrt(N));
divisors(K,N,_) when K*K == N -> [K|divisors(K+1,N,math:sqrt(N))];
divisors(K,N,_) -> [K,N div K] ++ divisors(K+1,N,math:sqrt(N)).

an(N, [H|_]) when N - H < 12 -> true;
an(N, [H|T]) ->
    case ets:lookup(abd, N-H) of
        [] -> an(N, T)
        ;_ -> false
    end.

