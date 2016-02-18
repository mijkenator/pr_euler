#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p32
% vim:syn=erlang

-mode(compile).

main(_) -> io:format("Answer ~p ~n", [t38(9876)]).

t38(9212) -> 0;
t38(N)    -> case isPandigital(integer_to_list(N) ++ integer_to_list(N*2)) of
                {true, A} -> A;
                false     -> t38(N-1)
             end.

isPandigital(N) ->
    case {length(N), lists:usort(N)} of
        {9, "123456789"} -> {true, N}
        ;_               -> false
    end.

