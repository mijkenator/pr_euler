#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p22
% vim:syn=erlang

-mode(compile).

worth(W) -> lists:foldl(fun(E,A)-> A + E - hd("A") + 1 end,0,W).

main(_) ->
    {ok, Data} = file:read_file("p022_names.txt"),
    S = size(Data)-2,
    <<"\"", D:S/binary, "\"">> = Data,
    L = lists:sort(binary:split(D,<<"\",\"">>,[global])),
    io:format("Answer: ~p ~n", [sum(L,1,0)]).

sum([], _, A)    -> A;
sum([H|T], I, A) -> sum(T,I+1,A+worth(binary_to_list(H))*I).
