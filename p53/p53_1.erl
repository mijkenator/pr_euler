#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p53
% vim:syn=erlang

-mode(compile).

main(_) -> io:format("Answer ~p ~n",[ p53() ]).

c(N, R) -> f(N) / (f(R)*f(N-R)).

f(0) -> 1;
f(1) -> 1;
f(N) ->
    case get({'f', N}) of
        undefined -> R = N*f(N-1), put({'f', N}, R), R;
        Ret       -> Ret
    end.

p53() ->
    Fun = fun(N,A) ->
        lists:foldl(fun(R,B)->
            case c(N,R) >= 1000000 of
                true -> B + 1
                ;_   -> B
            end
        end, 0, lists:seq(1,N)) + A
    end,
    lists:foldl(Fun, 0, lists:seq(1,100)).

