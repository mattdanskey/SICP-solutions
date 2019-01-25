
(append x y)
;(mcons 1 (mcons 2 (mcons 3 (mcons 4 (mcons 5 (mcons 6 '()))))))
; aka (1 2 3 4 5 6)

(cons x y)
;(mcons (mcons 1 (mcons 2 (mcons 3 '()))) (mcons 4 (mcons 5 (mcons 6 '()))))
; aka [(1 2 3) (4 5 6)] ([] denoting a pair)

(list x y)
;(mcons
; (mcons 1 (mcons 2 (mcons 3 '())))
; (mcons (mcons 4 (mcons 5 (mcons 6 '()))) '()))
; aka ((1 2 3) (4 5 6))

