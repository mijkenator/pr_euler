#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p20
% vim:syn=erlang

-mode(compile).

main(_) ->
    io:format("Answer: ~p ~n", [lists:foldl(fun(E,A)-> A + E - 48 end, 
                                            0, integer_to_list(fac(100)))]).

fac(1) -> 1;
fac(N) -> N*fac(N-1).
