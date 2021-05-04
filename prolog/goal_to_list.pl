likes(a, b).
likes(a, c).
likes(a, d).
likes(b, c).
likes(d, a).

list_likes(Term, Likes) :- bagof(Goal, likes(Term, Goal), Likes).
list_likes_sorted(Term, Likes) :- setof(Goal, likes(Term, Goal), Likes).
