#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p9
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = sum(2000000,2,0),
    io:format("Answer: ~p ~n", [Answer]).

sum(Max, Start, Sum) when Start =< Max ->
    case isprime(Start, 2, math:sqrt(Start)) of
        true -> sum(Max, Start+1, Sum + Start);
        _    -> sum(Max, Start+1,Sum)
    end;
sum(_, _, Sum) -> Sum.

isprime(N,PFactor,Max) when PFactor =< Max, N rem PFactor =:= 0 -> false;
isprime(N,PFactor,Max) when PFactor =< Max                      -> isprime(N,PFactor+1,Max);
isprime(_, _, _)                                                -> true.
