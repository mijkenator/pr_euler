#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p17
% vim:syn=erlang

-mode(compile).

main(_) ->
    io:format("Answer: ~p ~n", [lists:foldl(fun(E,A)-> A + length(ci(E)) end,0,lists:seq(1,1000))]).

word(N) ->
    L = [
        {   0,  ""         },
        {   1,  "one"      }, 
        {   2,  "two"      }, 
        {   3,  "three"    }, 
        {   4,  "four"     }, 
        {   5,  "five"     }, 
        {   6,  "six"      }, 
        {   7,  "seven"    }, 
        {   8,  "eight"    }, 
        {   9,  "nine"     }, 
        {  10,  "ten"      }, 
        {  11,  "eleven"   }, 
        {  12,  "twelve"   }, 
        {  13,  "thirteen" }, 
        {  14,  "fourteen" }, 
        {  15,  "fifteen"  }, 
        {  16,  "sixteen"  }, 
        {  17,  "seventeen"}, 
        {  18,  "eighteen" }, 
        {  19,  "nineteen" }, 
        {  20,  "twenty"   }, 
        {  30,  "thirty"   }, 
        {  40,  "forty"    }, 
        {  50,  "fifty"    }, 
        {  60,  "sixty"    }, 
        {  70,  "seventy"  }, 
        {  80,  "eighty"   }, 
        {  90,  "ninety"   }, 
        { 100,  "hundred"  }, 
        {1000,  "thousand" } 
    ],
    proplists:get_value(N, L).

ci(1000) -> word(1) ++ word(1000);
ci(100)  -> word(1) ++ word(100);
ci(N) when N > 100 -> 
    S = ci(N div 100) ++ word(100),
    case N rem 100 of
        0 -> S;
        M -> S ++ "and" ++ ci(M)
    end;
ci(N) ->
    case word(N) of
        undefined -> ci((N div 10)*10) ++ ci(N rem 10)
        ;W        -> W
    end.
    
