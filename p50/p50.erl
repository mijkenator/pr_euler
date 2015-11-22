#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p50
% vim:syn=erlang

-mode(compile).

main(_) ->
    PL = prime(5000),
    Answer = calc(0,PL,PL,0,[]),
    io:format("Answer ~p ~n",[ Answer ]).

calc(_,[],_,_,A) -> fetch_results(lists:reverse(lists:usort(A)));
calc(N,[H|T], O, R, A) when R+H < 1000000 -> calc(N+1,T,O,R+H, A);
calc(N,_,O, R, A) -> L = lists:sublist(O,2,length(O)-1),calc(0,L,L,0,A ++ [{N, R}]).


fetch_results([]) -> [];
fetch_results([{N,R}|T]) ->
    case is_prime(R) of
        true -> {N,R}
        ;_   -> fetch_results(T)
    end.

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

is_prime(N)   -> is_prime(N, 2).
%is_prime(N,N) -> true;
is_prime(N,M) when N rem M =:= 0 -> false;
is_prime(N,M) -> 
    case (M+1) < math:sqrt(N) of
        true -> is_prime(N,M+1)
        ;_   -> true
    end.

