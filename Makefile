all: _build/default/minischeme_test.exe

_build/default/minischeme_test.exe: ast.ml minischeme.ml minischeme_test.ml minischeme.mli lexer.mll parser.mly
	dune build minischeme_test.exe

.PHONY: runtests
runtests:
	dune exec ./minischeme_test.exe

.PHONY: clean
clean:
	dune clean
