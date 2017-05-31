all: clean build compile_mli build_docs
	@echo Done!

compile_mli:
	ocamlc -c solution_kh.mli

build:
	ocamlbuild solution_kh.native

build_docs:
	ocamldoc -html -d docs solution_kh.mli

docs: build_docs
	open docs/Solution_kh.html

clean:
	@if [ -a ./_build/sanitize.sh ] ; \
		then \
		_build/sanitize.sh ; \
		else \
		rm -rf _build solution_kh.cmi solution_kh.native; \
		fi;

