#!/usr/bin/swipl -tty -f
% vim: filetype=prolog
% Count numbers that are doubled odd numbers.

:- initialization(main).

main :-
  new(Dir, directory('.')),
  new(Frame, frame('Select file')),
  new(Browser, browser),
  new(Dialog, dialog),
  new(ProcessButton, button('Process!', message(@prolog, processfile, Browser?selection?key))),
  new(QuitButton, button('Quit', message(@prolog, halt))),
  send(Dialog, append(ProcessButton)),
  send(Dialog, append(QuitButton)),
  send(Browser, members(Dir?files)),
  send(Frame, append(Browser)),
  send(Dialog, below(Browser)),
  send(Frame, open).

processfile(F) :-
  see(F),
  count(0, N),
  showResult(N, F),
  seen.

count(X, D) :-
  read(N),
  (
    N == end_of_file ->
      D is X;
      (
        isOurNumber(N) ->
          X1 is X + 1;
          X1 is X
      ),
      count(X1, D)
  ).

showResult(X, F) :-
  new(D, dialog('RESULT')),
  new(B, button('Close', message(D, destroy))),
  new(V, view(F)),
  send(D, append(text('The result is'))),
  send(D, append(text(X), right)),
  send(D, append(V, below)),
  send(D, append(B, below)),
  send(V, load(F)),
  send(D, open).

isOurNumber(X) :-
  isEven(X),
  Y is X div 2,
  not(isEven(Y)).

isEven(X) :-
  Y is X mod 2,
  Y =:= 0.
