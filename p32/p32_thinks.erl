#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p32
% vim:syn=erlang

-mode(compile).

main(_) ->
    Answer = t32(),
    io:format("Answer ~p ~n", [Answer]).

t32() -> get_divs(123475968).

t32_() ->
    L = [list_to_integer(string:join(X,""))||X<-permutations(["1","2","3","4","5","6","7","8","9"])],
    Fun = fun(E, A) ->
        case get_divs(E) of
            [] -> A;
            R  -> A ++ [R]
        end
    end,
    lists:foldl(Fun, [], L).

get_divs(Num) ->
    io:format("~p ~n", [Num]),
    L = lists:filter(fun(1)->false;(N)-> 
        M = integer_to_list(N),
        length(M) == length(lists:usort(M))
    end, d(Num)),
    io:format("L: ~p ~n", [L]),
    M = comb(L,L,Num,[]),
    io:format("M: ~p ~n", [M]),

    Fun = fun(E) ->
        lists:foldl(fun(I,A)->A++integer_to_list(I) end,[],E)
    end,
    lists:filter(fun(LI)->length(LI)==length(lists:usort(LI)) end, 
        [Fun(E)||E<-cf(M, [])]).


permutations([]) -> [[]];
permutations(L)  -> [[H|T] || H <- L, T <- permutations(L--[H])].

%-----------------------------------------------------------------------------

d(0) -> [];
d(1) -> [];
d(N) -> lists:sort(divisors(1, N)).

divisors(1, N) -> [1|divisors(2,N,math:sqrt(N))].

divisors(K,_,Q) when K > Q -> [];
divisors(K,N,_) when N rem K =/= 0 -> divisors(K+1,N,math:sqrt(N));
divisors(K,N,_) when K*K == N -> [K|divisors(K+1,N,math:sqrt(N))];
divisors(K,N,_) -> [K,N div K] ++ divisors(K+1,N,math:sqrt(N)).

%------------------------------------------------------------------------------
comb([],_,_,A) -> [[X,Y]||[X,Y]<-A, Y=/=[]];
comb([H|T], L, N, A) when N rem H == 0 ->
    comb(T, L, N, A ++ [[H, N div H], [H, comb(L,L,N div H, [])]]);
comb([_|T], L, N, A) -> comb(T, L, N, A).

cf([], A) -> A;
cf([H|T]=L,A) when is_integer(H) ->
    io:format("CF1: ~p ... ~p  ... ~p ~n", [H,T,A]),
    case isfl(T) of
        true -> A ++ [[H|T]]
        ;_   -> cf(sl(L,[],[]), A) %%%%
    end;
cf([H|T],A) when is_list(H) ->
    io:format("CF2: ~p ... ~p  ... ~p ~n", [H,T,A]),
    case isfl(H) of
        true -> cf(T, A ++ [H])
        ;_   ->
            case mbfl(H) of
                {ok, H1} -> cf(T, A ++ [H1])
                ;_ -> cf(T, A ++ cf(H, []))
            end
    end.

sl([], [], A2) -> A2;
sl([], A1, []) -> A1;
sl([], A1, A2) -> [ A1 ++ E || E <- A2];
sl([H|T],A1,A2) when is_integer(H) -> sl(T, A1++[H], A2);
sl([H|T],A1,A2) -> sl(T,A1,A2++[H]).

isfl([]) -> true;
isfl([H|T]) when is_integer(H) -> isfl(T);
isfl(_) -> false.

mbfl(L) -> 
    case lists:sum([mbfli(E)||E<-L]) of
        0  -> {ok, lists:flatten(L)}
        ;_ -> L
    end.
    
mbfli(L) when is_integer(L) -> 0;
mbfli([L]) -> mbfli(L); 
mbfli(L)   -> case isfl(L) of
                true -> 0
                ;_   -> 1
              end.

