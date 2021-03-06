% Create a recursive structure (this loops 10 times):

loop(0) ->
    ok;
loop(Count) ->
    % do something
    loop(Count-1).
% Or from 1 to 10:

do_loop() ->
    loop(1).

loop(10) ->
    ok;
loop(Count) ->
    % do something
    loop(Count+1).

% You can also use lists:seq(1, 10) to get a sequence from 1 to 10.
