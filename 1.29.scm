#lang sicp

;gets 0.25 with n of 10, 100, and 1000.

(define (sum f a next b coefficient)
  (if (> a b)
    0
    (+ (* (coefficient a) (f a)) (sum f (next a) next b coefficient))))

(define (non-coefficient-sum f a next b)
  ; just to show how the new sum is a higher abstraction
  ; and how easy it is to wrap it to behave like the sum in the book
  (sum f a next b 1))

(define (approx f a b n)
  (define (h) (/ (- b a) n))

  (define (pass x) (+ a (* x (h))))

  (define (wrapped-f x)
    (f (pass x)))
  
  (define (co x)
    (if (or (= x 0) (= x n))
      1
      (if (= 1 (remainder x 2))
	4
	2)))

  (* (/ (h) 3.0)
     (sum wrapped-f 0 inc n co)))

(define (cube-approx n) 
  (define (cube x) (* x x x))
  (approx cube 0 1 n))
