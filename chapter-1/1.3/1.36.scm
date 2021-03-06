#lang sicp

(define tolerance 0.001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (display next)
      (newline)
      (if (close-enough? guess next)
	next
	(try next))))
  (try first-guess))

(define (average x y) (/ (+ x y) 2))

(display "regular")
(newline)
(fixed-point
  (lambda (x) (/ (log 1000) (log x)))
  20.0)
; 23 steps

(display "with average dampening")
(newline)
(fixed-point
  (lambda (x) (average x (/ (log 1000) (log x))))
  20.0)
; 9 steps
