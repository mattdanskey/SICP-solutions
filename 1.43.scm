#lang sicp

(define (repeated f n)
  (define (iter i newf)
    (if (= i 1)
      newf
      (iter (- i 1) 
	    (lambda (x) (f (newf x))))))
  (iter n f))

(define (square x) (* x x))

((repeated square 2) 5)
