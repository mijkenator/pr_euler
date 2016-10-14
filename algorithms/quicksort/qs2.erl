#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p9
% vim:syn=erlang

-mode(compile).

main(_) ->
    {A,B,C} = erlang:timestamp(),
    random:seed(A,B,C),
    L = [random:uniform(10000)||_<-lists:seq(1,5000000)],
    %io:format("Merge sort list: ~p ~n", [L]),
    %io:format("Merge sort list: ~p ~n", [qs(L, erlang:system_info(schedulers) )]).
    {T,_} = timer:tc(fun()->qs(L, erlang:system_info(schedulers)) end),
    io:format("Done ~p ~n", [T/1000000]).
    %

qs([],_) -> [];
qs([H|T], N) when N > 1  -> 
    {Parent, Ref} = {self(), make_ref()},
    spawn(fun()-> Parent ! {l1, Ref, qs([E||E<-T, E<H], N-2)} end), 
    spawn(fun()-> Parent ! {l2, Ref, qs([E||E<-T, H =< E], N-2)} end), 
    {L1, L2} = receive_results(Ref, undefined, undefined), 
    L1 ++ [H] ++ L2;
qs([H|T],_) ->
    qs([E||E<-T, E<H],0) ++ [H] ++ qs([E||E<-T, H =< E],0).

receive_results(Ref, L1, L2) ->
    receive
        {l1, Ref, L1R} when L2 == undefined -> receive_results(Ref, L1R, L2);
        {l2, Ref, L2R} when L1 == undefined -> receive_results(Ref, L1, L2R);
        {l1, Ref, L1R} -> {L1R, L2};
        {l2, Ref, L2R} -> {L1, L2R}
    after 5000 -> receive_results(Ref, L1, L2)
    end.

