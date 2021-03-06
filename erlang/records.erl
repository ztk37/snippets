% hello world program
-module(helloworld).
-export([start/0]).

-type props() :: map().
-export_type([props/0]).

-type opts() :: #{
    a => bitstring(),
    b => integer(),
    c => any()
}.
-export_type([opts/0]).

% -type other_params :: { value :: bitstring() }.

-record(usage_params, {name}).
-record(other_params, {value :: bitstring() }).

usage() -> usage(#usage_params{name="foo"}).

usage(#usage_params{name=Name}) ->
    % use io_lib format for returning strings
    % io:format returns ok '-'
    io_lib:format("usage ~s \n", [Name]).
    
% fiber(Value) when is_record(other_params) -> Value.name.

% Maps Module	Maps Syntax
% maps:new/1	#{}
% maps:put/3	Map#{Key => Val}
% maps:update/3	Map#{Key := Val}
% maps:get/2	Map#{Key}
% maps:find/2	#{Key := Val} = Map


-spec default_opts() -> opts(). 
default_opts() -> #{
    a => "dasd",
    b => 21
}.

-spec opts_a(opts()) -> bitstring().
opts_a(Opts) -> maps:get(a, Opts).

-spec bar(opts()) -> ok.
bar(_Opts) -> ok.

-spec fib(term()) -> bitstring().
fib(OtherParams) when is_record(OtherParams, other_params) -> OtherParams#other_params.value;
fib(Value) when is_integer(Value) -> integer_to_list(Value);
fib(Value) -> Value.

start() ->
    io:fwrite("~s\n", [fib(#other_params{value="derb"})]),
    io:fwrite("~s\n", [fib(#other_params{value="42"})]),
    io:fwrite("~s\n", [fib(undefined)]),
    io:fwrite("~s\n", [fib(1337)]),
    io:fwrite("~s\n", [fib("damn")]),
    io:fwrite("~s", [usage()]),
    io:fwrite("~p\n", [bar(#{})]),
    io:format("~s\n", [opts_a(default_opts())]).
