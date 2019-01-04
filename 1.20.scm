#lang sicp

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;normal order evaluation
(gcd 206 40)
(if (= 40 0) 206 (gcd 40 (remainder 206 40)))

(if (= (remainder 206 40) 0)
       40
       (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))
; [...]
; remainder gets called quite a few times with normal order evaluation
; as the result is needed in both the predicate and the alternative


;applicative order evaluation
(gcd 206 40)
(if (= 40 0) 206 (gcd (40 (remainder 206 40))))
(if (= 6 0) 40 (gcd (6 (remainder 40 6))))
(if (= 4 0) 6 (gcd (4 (remainder 6 4))))
(if (= 2 0) 4 (gcd (2 (remainder 4 2))))
(if (= 0 0) 2 (gcd (0 (remainder 2 0))))
; remainder gets called four times before the `if` predicate
; is true and the alternative expression is not evaluated.