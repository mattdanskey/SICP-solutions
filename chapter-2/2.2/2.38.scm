#lang sicp

; a property op should satisfy would be
; (= (op a b) (op b a))
; i.e. that op is commutative

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
	    (cdr rest))))
  (iter initial sequence))

(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
	(fold-right op
		    initial
		    (cdr sequence)))))


(fold-left / 1 (list 1 2 3))
(fold-right / 1 (list 1 2 3))
(fold-left list nil (list 1 2 3))
(fold-right list nil (list 1 2 3))
