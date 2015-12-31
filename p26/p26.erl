#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p26
% vim:syn=erlang

-mode(compile).


main(_) ->
    {_,Answer} = lists:last(lists:sort([ test26(X, []) || X <- lists:seq(1,10000)])),
    io:format("Answer: ~p ~n", [Answer]).

test26(N, [])      -> test26(N, [inc(1,N) rem N]);
test26(_, [0|_])   -> 0;
test26(N, [H|_]=L) ->
    D = inc(H,N) rem N,
    case lists:member(D, L) of
        true  -> {length(L) - indx(D, lists:reverse(L), 0), N}
        ;_ -> test26(N, [D | L])
    end.

indx(D, [D|_], I) -> I;
indx(D, [_|T], I) -> indx(D, T, I+1).

inc(H,N) when H >= N -> H;
inc(H,N) -> inc(H*10, N).
