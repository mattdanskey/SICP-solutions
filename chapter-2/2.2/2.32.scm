#lang sicp

(define (subsets s)
  (define (f x) (display "magic here"))
  (if (null? s)
    (list nil)
    (let ((rest (subsets (cdr s))))
      (append rest
	      (map f rest)))))

(define (p s)
  (for-each (lambda (x)
	      (display x)
	      (newline))
	    s))

(p (subsets (list 1 2 3)))
