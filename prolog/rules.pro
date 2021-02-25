language(bob, javascript).
language(jack, javascript).
language(phil, php).
language(phil, javascript).

team(foo).
team(bar).
team(fib).

member(team(foo), bob).
member(team(foo), jack).
member(team(foo), phil).

editor(bob, vim).
editor(jack, emacs).

friends(A, B) :-
    language(A, Language),
    language(B, Language),
    editor(A, Editor),
    editor(B, Editor).

members(Team) :- members(Team, []).
members(Team, Members) :-
    team(Team),
    findall(Member, member(team(Team), Member), Members). 

show_members(Team) :-
    ( team(Team) ->
        (members(Team, Members) ->
            write(Members)
        ; write("no members")
        )
    ; write("unknown team")
    ).
