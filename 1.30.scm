#lang sicp

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
      result 
      (iter (next a) (+ result (term a)))))
  (iter a 0))

(sum + 2 inc 4) ;9
