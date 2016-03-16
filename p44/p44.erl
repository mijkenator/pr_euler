#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p44
% vim:syn=erlang
-mode(compile).

fun_i(M) -> (math:sqrt(24*M+1)+1) / 6.
fun_d(N) -> N*(3*N-1) / 2.

main(_) -> io:format("Answer: ~p ~n", [t44(2,1)]).

t44(I,0) -> t44(I+1,I);
t44(I,J) -> 
    {N, N1} = {fun_d(I), fun_d(J)},
    {P1,P2} = {fun_i(N-N1), fun_i(N+N1)},
    case {P1==round(P1), P2==round(P2)} of
        {true, true} -> round(N-N1)
        ;_           -> t44(I,J-1)
    end.
        

    
