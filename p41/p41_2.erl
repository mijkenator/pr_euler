#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p41
% vim:syn=erlang

main(_) -> 
    Answer = t41([list_to_integer(string:join(X,""))||X<-permutations(["7","6","5","4","3","2","1"])]),
    io:format("Answer: ~p ~n", [Answer]).

permutations([]) -> [[]];
permutations(L)  -> [[H|T] || H <- L, T <- permutations(L--[H])].

t41([N|T]) ->
    case is_prime(N) of
        true -> N
        ;_   -> t41(T)
    end.

is_prime(N)   -> is_prime(N, 2).
is_prime(N,M) when N rem M =:= 0 -> false;
is_prime(N,M) -> 
    case (M+1) < math:sqrt(N) of
        true -> is_prime(N,M+1)
        ;_   -> true
    end.

