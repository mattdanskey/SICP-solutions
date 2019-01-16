#lang sicp

; 1)

; a) write a procedure `product` analogous to `sum`
(define (product f a next b)
  (if (> a b)
    1
    (* (f a) 
       (product f (next a) next b))))

; b) define `factorial in terms of `product`
(define (factorial x)
  (define (identity x) x)
  (product identity 1 inc x))

; c) use `product` to compute approximation of pi using the given formula
(define (approx-pi n)
  (define (numf x) (+ x (remainder x 2)))
  (define (denf x) (+ 1 (- x (remainder x 2))))

  (* 4.0
     (/ (product numf 2 inc n)
	(product denf 2 inc n))))

; 2) rewrite `product` to be iterative if it is recursive, or vice versa
(define (iterative-product f a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (* (f a) result))))
  (iter a 1))

