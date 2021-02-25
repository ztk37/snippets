male(niclas).
male(daniel).
male(felix).
female(bemu).

age(niclas, 19).
age(cedric, 24).

is_male(X) :- male(X).

sum(List, Sum) :- sum(List, 0, Sum).
sum([H|T], Acc, Sum) :- Acc2 is Acc + H, sum(T, Acc2, Sum).
sum([], X, X).

inc(X, Y) :- Y is X + 1.

first([First|_], First).
first_deep([[First|_]|_], First).

keys(List, Keys) :- maplist(keys_aux, List, Keys).
keys_aux([Key|_], Key).

values(List, Values) :- maplist(values_aux, List, Values).
values_aux([_|[Value|_]], Value).

make_vector(X,Y,Z,Vec) :- Vec=vector{x:X,y:Y,z:Z}.

zero_vector(Vec) :- make_vector(0,0,0, Vec).

vector_add(Vec1, Vec2, Vec) :-
    X is Vec1.x + Vec2.x,
    Y is Vec1.y + Vec2.y,
    Z is Vec1.z + Vec2.z,
    Vec=vector{x:X,y:Y,z:Z}.

% vector_example(Vec) :- {Vec}/(make_vector(1,1,1, Vec1), make_vector(2,2,2, Vec2), vector_add(Vec1, Vec2, Vec)).
vector_example(Vec) :-
    make_vector(1,1,1, Vec1),
    make_vector(2,2,2, Vec2),
    vector_add(Vec1, Vec2, Vec).

sum_(X,Y,Z) :- Z is X + Y.
fold_sum(List, N) :- foldl(sum_, List, 0, N).
