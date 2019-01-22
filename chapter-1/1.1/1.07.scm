#lang sicp

; For small numbers, the 0.001 threshhold for the check
; is a practical limit for accuracy as the number approaches
; the size of the threshhold.

; For large numbers, I imagine these are floating point numbers
; internally, so the decimel precision is lost, and `good-enough?`
; will never be true.

; Below is an altered version that checks the change between
; the previous and current guess instead of between the
; squared guess and the original number

(define (square x) (* x x))

(define (good-enough? guess previous)
  (< (abs (- guess previous))
     0.001))
          
(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess previous x)
  (if (good-enough? guess previous)
      guess
      (sqrt-iter (improve guess x)
                 guess
                 x)))

(define (sqrt x)
  (sqrt-iter 1.0 0 x))