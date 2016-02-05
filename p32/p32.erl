#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p32
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = lists:sum(lists:usort([X*Y||X<-lists:seq(1,99),Y<-lists:seq(100,9999), isPandigital(X,Y)])),
    io:format("Answer ~p ~n", [Answer]).

isPandigital(X,Y) ->
    P = X * Y,
    S = integer_to_list(X) ++ integer_to_list(Y) ++ integer_to_list(P),
    case {length(S), lists:usort(S)} of
        {9, "123456789"} -> true
        ;_               -> false
    end.
