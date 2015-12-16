#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname p17
% vim:syn=erlang

-mode(compile).

main(_) ->
    io:format("Answer: ~p ~n", [lists:foldl(fun(E,A)-> A + length(t17(E)) end,0,lists:seq(1,1000))]).

words() ->
        [
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
    ].

w(N) -> proplists:get_value(N, words()).

t17(1000) -> w(1) ++ w(1000);
t17(100)  -> w(1) ++ w(100);
t17(N) when N =< 20 -> w(N);
t17(N) when N < 100 -> t17i(N, lists:reverse(words()));
t17(N) when N rem 100 =:= 0 -> w(N div 100) ++ w(100);
t17(N) -> w(N div 100) ++ w(100) ++ "and" ++ t17(N rem 100). 

t17i(N, [{N, W}|_]) -> W; 
t17i(N, [{M, W}|_]) when N > M -> W ++ w(N-M);
t17i(N, [_|T]) -> t17i(N, T).

