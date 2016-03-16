#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p45
% vim:syn=erlang
-mode(compile).

pen_i(M) -> (math:sqrt(24*M+1)+1) / 6.
hex_d(N) -> N*(2*N-1).

main(_) -> io:format("Answer: ~p ~n", [t45(144)]).

t45(I) ->
    P = pen_i(hex_d(I)),
    case round(P) == P of
        true -> hex_d(I)
        ;_   -> t45(I+1)
    end.
