
let test_add () =
  Alcotest.(check string) "same int" "6" (Minischeme.interp "6")


let () =
  let open Alcotest in
  run "SchemeTests" [
      "adition", [ test_case "Test addition" `Slow test_add ];
    ]
