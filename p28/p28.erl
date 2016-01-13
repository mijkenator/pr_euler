#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p28
% vim:syn=erlang

-mode(compile).

main(_) -> 
    io:format("Answer ~p ~n", [t28(500)]).

t28(0) -> 1;
t28(N) -> 4*(2*N+1)*(2*N+1) - 12*N + t28(N-1).

