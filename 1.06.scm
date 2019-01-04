#lang sicp

; `new-if` results in an endless loop when used here.
; This is because the else-clause gets evaluated
; regardless of whether the predicate is true or false
; and so `sqrt-iter` calls itself infinitely.


(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (square x) (* x x))

(define (good-enough? guess x)
  (< (abs (-
           (square guess)
           x))
     0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))
