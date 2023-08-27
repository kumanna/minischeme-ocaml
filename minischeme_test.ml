
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

let test_combined1 () =
  Alcotest.(check string) "same int" "36" (Minischeme.interp "(* 1 (* 2 1) (+ 1 2) (* 1 2 3))")

let test_combined2 () =
  Alcotest.(check string) "same int" "36" (Minischeme.interp "(+ (* -2 -3) (* -5 -6))")

let test_float_1 () =
  Alcotest.(check string) "same float" "0.01" (Minischeme.interp "0.01")  

let test_float_2 () =
  Alcotest.(check string) "same float" "-3.14" (Minischeme.interp "-3.14")  

let test_float_add1 () =
  Alcotest.(check string) "same int" "6.0" (Minischeme.interp "(+ 1.0 2.0 3)")

let test_float_add2 () =
  Alcotest.(check string) "same int" "12.0" (Minischeme.interp "(+ 1 2 3 (+ 1 2 3.0))")

let test_float_mult1 () =
  Alcotest.(check string) "same int" "6.0" (Minischeme.interp "(* 1 2 3.0)")

let test_float_mult2 () =
  Alcotest.(check string) "same int" "36.0" (Minischeme.interp "(* 1 2 3 (* 1 2 3.0))")

let test_float_combined1 () =
  Alcotest.(check string) "same int" "36.0" (Minischeme.interp "(* 1 (* 2 1) (+ 1 2) (* 1.0 2 3))")

let test_float_combined2 () =
  Alcotest.(check string) "same int" "36.0" (Minischeme.interp "(+ (* -2 -3.0) (* -5 -6.0))")

let () =
  let open Alcotest in
  run "SchemeTests" [
      "int", [ test_case "Test integer parsing" `Slow test_int ];
      "addition1", [ test_case "Test integer addition" `Slow test_add1 ];
      "addition2", [ test_case "Test integer addition" `Slow test_add2 ];
      "multiplication1", [ test_case "Test integer multiplication" `Slow test_mult1 ];
      "multiplication2", [ test_case "Test integer multiplication" `Slow test_mult2 ];
      "combined1", [ test_case "Test integer combined" `Slow test_combined1 ];
      "combined2", [ test_case "Test integer combined" `Slow test_combined2 ];
      "float1", [ test_case "Test float" `Slow test_float_1 ];
      "float2", [ test_case "Test float" `Slow test_float_2 ];
      "float3", [test_case "Test float arithmetic" `Slow test_float_add1 ];
      "float4", [test_case "Test float arithmetic" `Slow test_float_add2 ];
      "float5", [test_case "Test float arithmetic" `Slow test_float_mult1 ];
      "float6", [test_case "Test float arithmetic" `Slow test_float_mult2 ];
      "float7", [test_case "Test float arithmetic" `Slow test_float_combined1 ];
      "float8", [test_case "Test float arithmetic" `Slow test_float_combined2 ];
    ]
