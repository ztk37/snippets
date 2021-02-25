-module(list_files).

-export([list_files_in_cwd/0]).

list_files_in_cwd() ->
    {ok, CWD} = file:get_cwd(),
    file:list_dir(CWD).
