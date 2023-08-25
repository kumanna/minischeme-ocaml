(lang dune 3.10)
(name minischeme)
(generate_opam_files true)
(license MIT)
(authors "Kumar Appaiah <a.kumar@alumni.iitm.ac.in>")
(source
 (github kumanna/minischeme-ocaml))
(using menhir 2.1)

(package
 (name minischeme)
 (synopsis "A partial Scheme expression interpreter written in OCaml")
 (description "A partial Scheme epxression interpreter written in OCaml.")
 (depends
  (alcotest :with-test)
  (ocaml
   (>= 4.02.3))
  dune
 (menhir :with-test)
 (ocaml
  (>= 4.02.3))))
