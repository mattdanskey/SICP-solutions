#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
	((= x (car set)) true)
	((< x (car set)) false)
	(else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (null? set) 
      (list x)
      (let ((x1 (car set)))
	(cond ((= x1 x) set)
	      ((< x x1) (cons x set))
	      ((> x x1) (cons x1 (adjoin-set x (cdr set))))))))

(equal? (adjoin-set 2 '(1 3))
	'(1 2 3))
