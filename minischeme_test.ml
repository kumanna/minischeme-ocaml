
let test_add () =
  Alcotest.(check int) "same int" 6 (Minischeme.interp "(+ 1 2 3)")


let () =
  let open Alcotest in
  run "SchemeTests" [
      "adition", [ test_case "Test addition" `Slow test_add ];
    ]
