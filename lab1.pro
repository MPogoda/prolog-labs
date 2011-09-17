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

processfile(X) :-
  see(X),
  count(0, X),
  seen.

count(X, F) :-
  read(N),
  (
    N == end_of_file ->
      showResult(X, F);
      (
        isOurNumber(N) ->
          X1 is X + 1;
          X1 is X
      ),
      count(X1, F)
  ).

showResult(X, F) :-
  new(D, dialog('RESULT')),
  new(B, button(X, message(D, destroy))),
  new(V, view(F)),
  send(D, append(B)),
  send(D, append(V, below)),
  send(V, load(F)),
  send(D, open).

isOurNumber(X) :-
  isEven(X),
  Y is X div 2,
  not(isEven(Y)).

isEven(X) :-
  Y is X mod 2,
  isZero(Y).

isZero(0).
