% hello world program
-module(test).
-export([start/0]).

abc(a) -> {ok, "a"};
abc(b) -> {ok, "b"};
abc(c) -> {ok, "c"};
abc(_) -> {error, "inpust must be on of a b c"}.

start() ->
    v = case abc(a) of
        {ok, "a"} -> "a";
        {ok, "b"} -> "b";
        {ok, "c"} -> "c";
        {error, msg} -> msg
    end,
    io:fwrite(v).
