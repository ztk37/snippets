entry(react, component, none).
entry(react, component, prop).
entry(software, component, name).

all_entries(Entries) :-
    findall((Subject, Predicate, Object), entry(Subject, Predicate, Object), Entries). 

% convenience predicate
is_entry(Subject, Predicate, Object) :- entry(Subject, Predicate, Object).

% findall((A,component, B), triple(A, component, B), XS).
filter_by_subject(Subject, Entries) :-
    findall((Subject, Predicate, Object), entry(Subject, Predicate, Object), Entries).
filter_by_predicate(Predicate, Entries) :-
    findall((Subject, Predicate, Object), entry(Subject, Predicate, Object), Entries).
filter_by_oroject(Object, Entries) :-
    findall((Subject, Predicate, Object), entry(Subject, Predicate, Object), Entries).
