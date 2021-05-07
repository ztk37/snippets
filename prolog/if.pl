registry(a).
registry(b).
registry(c).
registry(d).
registry(e).

is_registered(ID) :- registry(ID).

main :-
  ( is_registered(x) ->
    writeln('!')
  ; 
    writeln('?')
  ).
  
:- main.
