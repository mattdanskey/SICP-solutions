#lang sicp

(define (cube x) (* x x x))

(define (good-enough? guess x)
  (< (abs (-
           (cube guess)
           x))
     0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (/ (+ (/ x (* guess guess))
        (* 2 guess))
     3))

(define (curt-iter guess x)
  (if (good-enough? guess x)
      guess
      (curt-iter (improve guess x) x)))

(define (curt x)
  (curt-iter 1.0 x))

(curt 125)
(curt 1000)
(curt 9)