#lang sicp
(define (square a) (* a a))

(define (sum-of-squares a b)
  (+ (square a) (square b)))

(define (last-lowest a b c)
  (and (> a c) (> b c)))

(define (ss-highest-two a b c)
  (cond ((last-lowest a b c) (sum-of-squares a b))
        ((last-lowest a c b) (sum-of-squares a c))
        (else (sum-of-squares b c))))

(ss-highest-two 1 2 3)
(ss-highest-two 2 3 1)
(ss-highest-two 3 2 1)
(ss-highest-two 1 3 2)