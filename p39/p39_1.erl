#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p39
% vim:syn=erlang

answer() ->
    Tris = [ A+B+C || C <- lists:seq(1, 500),
                      B <- lists:seq(1, C-1),
                      A <- lists:seq(1, B),
                      (A*A + B*B) =:= (C*C),
                      (A+B+C) =< 1000 ],
    Sorted = lists:sort(Tris),
    find_p(Sorted, hd(Sorted), 0, 0, hd(Sorted)).

find_p([], _, _, _, MaxP)            -> MaxP;
find_p([P | Ps], P, C, Max, MaxP)    -> find_p(Ps, P, C+1, Max, MaxP);
find_p([P | Ps], CurP, C, Max, MaxP) ->
    case C > Max of
        true  -> find_p(Ps, P, 0, C, CurP);
        false -> find_p(Ps, P, 0, Max, MaxP)
    end.


main(_) ->
    io:format("Answer: ~p ~n", [answer()]).

