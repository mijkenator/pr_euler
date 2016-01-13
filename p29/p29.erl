#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p29
% vim:syn=erlang

-mode(compile).

main(_) -> io:format("Answer ~p ~n", [t29()]).

t29() ->
    length(deduplicate(lists:flatten([ [math:pow(X, Y), math:pow(Y, X)] || X <- lists:seq(2,100), Y <- lists:seq(2,100)]), [])).
deduplicate([],L1) -> L1;
deduplicate([H|T], L1) ->
    case lists:member(H, L1) of
        true -> deduplicate(T,L1);
        _    -> deduplicate(T,[H] ++ L1)
    end. 
