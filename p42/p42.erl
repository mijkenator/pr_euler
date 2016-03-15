#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p42
% vim:syn=erlang

is_trangle(X) ->
    T = lists:sum([C-96||C<-string:to_lower(binary_to_list(X))]),
    N = (math:sqrt(1+8*T)-1)/2, 
    case round(N) == N of
        true -> 1
        ;_   -> 0
    end.

main(_) -> 
    {ok, C} = file:read_file("/home/mkh/work/mblog/pr_euler/p42/p042_words.txt"),
    W = [binary:part(X,1,size(X)-2)||X<-binary:split(C,<<",">>,[global])],
    Answer = lists:sum([is_trangle(X)||X<-W]),
    io:format("Answer: ~p ~n", [Answer]).

