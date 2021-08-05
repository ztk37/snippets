-module(main).

-export([
		 xs/0,
		 proc/2,
		 start/0
]).

xs() -> [{a, 1}, {b, 2}, {c, 3}].

proc({a, Val}, State) -> State + Val;
proc({b, Val}, State) -> State - Val;
proc({c, _}, State) -> State;
proc(_, State) -> State.

start() ->
	Fun = fun(Cur, Acc) -> proc(Cur, Acc) end,  
	XS = lists:foldl(Fun, 0, xs()),
	io:fwrite("~p~n", [ XS ]).
