main :-
  new(Dir, directory('.')),
  new(Frame, frame('Select file')),
  new(Browser, browser),
  new(Dialog, dialog),
  send(Dialog, append(button('Open', message(@prolog, openfile, Browser?selection?key)))),
  send(Dialog, append(button('Quit', message(@prolog, halt)))),
  send(Browser, members(Dir?files)),
  send(Frame, append(Browser)),
  send(Dialog, below(Browser)),
  send(Frame, open).

openfile(Filename) :-
  see(Filename),
  read_list(List),
  search_form(Filename, List),
  seen.

read_list(List) :-
  (
    at_end_of_stream ->
      List = [];
      read(Pair), read_list(List1), List = [Pair | List1]
  ).

search_form(Filename, List) :-
  new(D, dialog('Assoc')),
  new(V, view(Filename)),
  send(V, load(Filename)),
  new(Query, text_item(query)),
  send(D, append(text('The file contains next k/v pairs:'))),
  send(D, append(V, below)),
  send(D, append(Query, below)),
  send(D, append(button('Search by key', message(@prolog, query_key, Query?selection, prolog(List))))),
  send(D, append(button('Select by value', message(@prolog, query_value, Query?selection, prolog(List))))),
  send(D, append(button('Close', message(D, destroy)), below)),
  send(D, open).

query_key(Key, List) :-
  find_by_key(List, Key, Value),
  show_value(Value).

query_value(V, List) :-
  atom_number(V, Value),
  find_by_value(List, Key, Value),
  show_value(Key).

show_value(Value) :-
  new(F, dialog),
  send(F, append, text(Value)),
  send(F, append, button(close, message(F, destroy))),
  send(F, open).

find_by_key([ K/V | _ ], K, Value) :-
  Value = V.
find_by_key([ _ | Tail], Key, Value) :-
  find_by_key(Tail, Key, Value).
find_by_key( _, _, Value) :-
  Value = 'Not found'.

find_by_value([ K/V | _], Key, V) :-
  Key = K.
find_by_value([ _ | Tail], Key, Value) :-
  find_by_value(Tail, Key, Value).
find_by_value( _, Key, _) :-
  Key = 'Not found'.
