#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p9
% vim:syn=erlang

-mode(compile).

sieve(Candidates,SearchList,Primes,_Maximum) when length(SearchList) == 0 ->
    ordsets:union(Primes,Candidates);
sieve(Candidates,SearchList,Primes,Maximum)  ->
     H = lists:nth(1,string:substr(Candidates,1,1)),
     Reduced1 = ordsets:del_element(H, Candidates),
     {Reduced2, ReducedSearch} = remove_multiples_of(H, Reduced1, SearchList),
     NewPrimes = ordsets:add_element(H,Primes),
     sieve(Reduced2, ReducedSearch, NewPrimes, Maximum).
 
remove_multiples_of(Number,Candidates,SearchList) ->                                 
    NewSearchList = ordsets:filter( fun(X) -> X >= Number * Number end, SearchList), 
    RemoveList = ordsets:filter( fun(X) -> X rem Number == 0 end, NewSearchList),
    {ordsets:subtract(Candidates, RemoveList), ordsets:subtract(NewSearchList, RemoveList)}.
 
main(_) ->      
    N = 20000000,
    CandidateList = lists:seq(3,N,2),
    Candidates = ordsets:from_list(CandidateList),
    ResultSet = ordsets:add_element(2,sieve(Candidates,Candidates,ordsets:new(),N)),
    io:format("Answer: ~p ~n", [lists:foldl(fun(E,A)->E+A end, 0, ResultSet)]).
