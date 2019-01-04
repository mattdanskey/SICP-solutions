#lang sicp

(define (p) (p))

(define (test x y)
  (if (= x y)
      0
      y))

;(test 0 (p)) for applicative order will run in an endless loop,
;since p will call itself endlessly and the expression (p) will be evaluated
;before `test` is called.
;If the interpreter uses normal order, then (p) would not be evaluated until the
;predicate of the if statement is determined to be false. When passing in 0, it is
;true, and so (p) does not get evaluated.