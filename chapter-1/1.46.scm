#lang sicp


(define (iterative-improve good-enough? improve)
  (define (iter guess) 
    (if (good-enough? guess)
      guess
      (iter (improve guess))))
  iter)

(define (average x y) (/ (+ x y) 2))

(define (square x) (* x x))

; sqrt procedure rewrite

(define (sqrt x)
  ((iterative-improve
    (lambda (guess) (< (abs (- x (square guess))) 0.00001))
    (lambda (guess) (average guess (/ x guess)))) 1.0))

(sqrt 4)

; fixed-point

(define (fixed-point f first-guess)
  ((iterative-improve
     (lambda (guess) 
       (< (abs (- guess (f guess))) 0.0001))
     (lambda (guess)
       (f guess))) first-guess))

(fixed-point cos 1.0)
; ~0.73

(define (fsqrt x)
  (fixed-point (lambda (y) (average y (/ x y))) 1.0))
