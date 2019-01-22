; If we ask the interpreter to evaluate `(f f)`,
; the interpreter will complain, as f gets passed in
; and we get the expression (f 2), which brings us
; to the expression (2 2), which the interpreter does not like,
; as 2 is not a procedure.
