% vim: filetype=prolog

% salary(fio, ID, hours, perhour, kol)

:-
  assertz(salary('Jobbs, Steve', 000000001, 5, 1, 0)),
  assertz(salary('Torvalds, Linus', 000000002, 10, 100, 2)),
  assertz(salary('Gates, Bill', 000000003, 100, 1, 5)).

new_fact(Fio, Id, Hours, Perhour, Kol) :-
  not(salary(_, Id, _, _, _)),
  assertz(salary(Fio, Id, Hours, Perhour, Kol)).

remove_fact(Id) :-
  salary(F, Id, H, P, K),
  retract(salary(F, Id, H, P, K)).

total_hours :-
  salary(F, _, H, _, _),
  write(F), write('\t'), write(H), nl,
  fail.
total_hours :-
  findall(Id, salary(_, Id, _, _, _), List),
  total_hours(List, N),
  write('Total\t\t'), write(N), nl.
total_hours([Id | List], N) :-
  total_hours(List, N1),
  salary(_, Id, Hours, _, _),
  N is N1 + Hours.
total_hours(_, N) :-
  N is 0.

total_warrant :-
  salary(F, Id, H, P, _),
  W is H * P * 0.02,
  write(F), write('\t'), write(W), nl,
  fail.
total_warrant :-
  findall(Id, salary(_, Id, _, _, _), List),
  total_warrant(List, W),
  write('Total\t\t'), write(W), nl.
total_warrant([ Id | List], W) :-
  total_warrant(List, W1),
  salary(_, Id, H, P, _),
  W is W1 + H * P * 0.02.
total_warrant(_, W) :-
  W is 0.
