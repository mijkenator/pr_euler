#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p19
% vim:syn=erlang

-mode(compile).

main(_) ->
    io:format("Answer: ~p ~n", [length([ 1 || Y <- lists:seq(1901, 2000),  
                                              M <- lists:seq(1, 12), 
                                              calendar:day_of_the_week(Y,M,1) =:= 7 ])]).

