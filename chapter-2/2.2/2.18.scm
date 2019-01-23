#lang sicp

(define (reverse items)
  (define (r-iter result left)
    (if (null? left)
      result
      (r-iter (cons (car left) result)
	      (cdr left))))
  (r-iter nil items))

(reverse (list 1 2 3 4))
