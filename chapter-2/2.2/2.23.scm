#lang sicp

(define (for-each proc items)
  (cond ((null? items) #t)
	(else (proc (car items))
	      (for-each proc (cdr items)))))


(for-each (lambda (x) (newline) (display x))
	  (list 1 2 4 5 6 10))
