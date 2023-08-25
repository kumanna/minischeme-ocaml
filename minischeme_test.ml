
let test_int () =
  Alcotest.(check string) "same int" "6" (Minischeme.interp "6")

let test_add1 () =
  Alcotest.(check string) "same int" "6" (Minischeme.interp "(+ 1 2 3)")

let test_add2 () =
  Alcotest.(check string) "same int" "12" (Minischeme.interp "(+ 1 2 3 (+ 1 2 3))")

let test_mult1 () =
  Alcotest.(check string) "same int" "6" (Minischeme.interp "(* 1 2 3)")

let test_mult2 () =
  Alcotest.(check string) "same int" "36" (Minischeme.interp "(* 1 2 3 (* 1 2 3))")


let () =
  let open Alcotest in
  run "SchemeTests" [
      "int", [ test_case "Test integer parsing" `Slow test_int ];
      "addition1", [ test_case "Test integer addition" `Slow test_add1 ];
      "addition2", [ test_case "Test integer addition" `Slow test_add2 ];
      "multiplication1", [ test_case "Test integer multiplication" `Slow test_mult1 ];
      "multiplication2", [ test_case "Test integer multiplication" `Slow test_mult2 ];
    ]
