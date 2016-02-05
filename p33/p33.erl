#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p33
% vim:syn=erlang

-mode(compile).

main(_) ->
    {N,M} = lists:foldl(fun({A,B}, {C,D})-> {A*C,B*D} end, {1,1}, 
        [{X,Y}||X<-lists:seq(10,99), Y<-lists:seq(10,99), isPhr(X,Y), X < Y]),
    io:format("Answer ~p ~n", [ round(M / N) ]).

isPhr(X,X) -> false;
isPhr(X,_) when X rem 10 == 0 -> false;
isPhr(_,Y) when Y rem 10 == 0 -> false;
isPhr(X,Y) ->
    case sets:to_list(sets:intersection(sets:from_list(integer_to_list(X)),
                                           sets:from_list(integer_to_list(Y)))) of
        []    -> false;
        Inter ->
            XX = [X1 || X1<- integer_to_list(X), lists:member(X1,Inter) == false],            
            YY = [Y1 || Y1<- integer_to_list(Y), lists:member(Y1,Inter) == false],
            case {XX,YY} of
                {"", _} -> false;
                {_, ""} -> false;
                {"0",_} -> false;
                {_,"0"} -> false;
                _ ->
                    case X/Y == list_to_integer(XX)/list_to_integer(YY) of
                        true -> true
                        ;_   -> false
                    end
            end
    end.



