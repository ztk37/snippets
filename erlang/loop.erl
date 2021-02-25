-module(proc).

-export([loop/0, loop/1]).

loop() ->
    loop(0).

loop(State) ->
    receive
        	msg -> {ok, State};

            {no, Why} -> {yes, Why};

            Msg -> Msg
    end.
