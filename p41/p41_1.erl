#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p41
% vim:syn=erlang

main(_) -> 
    io:format("Answer: ~p ~n", [t41(7654321)]).

t41(N) ->
    case is_prime(N) of
        true -> case isPandigital(integer_to_list(N)) of
                    true -> N
                    ;_   -> t41(N-1)
                end
        ;_   -> t41(N-1)
    end.

isPandigital(N) ->
    case {length(N), lists:usort(N)} of
        {7, "1234567"} -> true
        ;_             -> false
    end.

is_prime(N)   -> is_prime(N, 2).
is_prime(N,M) when N rem M =:= 0 -> false;
is_prime(N,M) -> 
    case (M+1) < math:sqrt(N) of
        true -> is_prime(N,M+1)
        ;_   -> true
    end.

