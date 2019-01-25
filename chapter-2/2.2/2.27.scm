#lang sicp

(define (reverse items)
  (define (r-iter result left)
    (if (null? left)
      result
      (r-iter (cons (car left) result)
	      (cdr left))))
  (r-iter nil items))

(define (deep-reverse x)
  (define (iter result left)
    (cond ((null? left)
	   result)
          ((pair? (car left))
	   (iter (cons (iter nil (car left)) result)
		 (cdr left)))
    	  (else (iter (cons (car left) result)
		      (cdr left)))))
  (iter nil x))

(deep-reverse (list (list 1 2) 3 4))

