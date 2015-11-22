#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p7
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = lists:nth(10001, prime(110000)),
    io:format("Answer: ~p ~n", [Answer]).


prime(2)                    -> [2] ;
prime(N) when N > 2, N =< 6 -> prime(lists:seq(3,N,2),[2]);
prime(N) when N > 6         ->
    prime(lists:merge( [6*K-1 || K <- lists:seq(1,(N+1) div 6)], [6*K+1 || K <- lists:seq(1,(N-1) div 6)] ), [2,3]);
prime(_)                    -> [].

prime(X,P)                  -> prime(X,lists:reverse(P),P).

prime([],_,P)                                          -> lists:reverse(P) ;
prime([H|T],[HP|TP],P) when HP * HP =< H,H rem HP > 0  -> prime([H|T],TP,P);
prime([H|T],[HP|_],P)  when HP * HP > H                -> prime(T,[H|P]);
prime([_|T],_,P)                                       -> prime(T,P).
