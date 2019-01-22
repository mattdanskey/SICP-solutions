#lang sicp

(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a)
	      (accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (identity x) x)

(sum identity 1 inc 4)
(product identity 1 inc 5)

; iterative version
(define (iterative-accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(define (isum term a next b)
  (iterative-accumulate + 0 term a next b))

(define (iproduct term a next b)
  (iterative-accumulate * 1 term a next b))

(isum identity 1 inc 4)
(iproduct identity 1 inc 5)


