% vim: filetype=prolog
% Count numbers that are doubled odd numbers.

main :-
  new(Dir, directory('.')),
  new(Frame, frame('Select file')),
  new(Browser, browser),
  new(Dialog, dialog),
  send(Dialog, append(button(
        'Process!', message(@prolog, processfile, Browser?selection?key))
  )),
  send(Dialog, append(button(
        'Quit', message(@prolog, halt))
  )),
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
  (
    at_end_of_stream ->
      D is X;
      read(N),
      (
        integer(N) ->
          (
            isOurNumber(N) ->
              X1 is X + 1;
              X1 is X
          ), count(X1, D);
          not_integer(N), seen
      )
  ).

not_integer(X) :-
  new(D, dialog('Error')),
  send(D, append(text('Error!'))),
  send(D, append(text(X), right)),
  send(D, append(text('is not an integer'), right)),
  send(D, append(button('Okay', message(D, destroy), below))),
  send(D, open).

isOurNumber(X) :-
  isEven(X),
  Y is X div 2,
  not(isEven(Y)).

isEven(X) :-
  Y is X mod 2,
  Y =:= 0.

showResult(X, F) :-
  new(D, dialog('RESULT')),
  new(V, view(F)),
  send(D, append(text('The result is'))),
  send(D, append(text(X), right)),
  send(D, append(V, below)),
  send(D, append(button('Close', message(D, destroy)), below)),
  send(V, load(F)),
  send(D, open).
