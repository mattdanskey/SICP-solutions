#lang sicp

(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))

; 1)
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (car (cdr mobile)))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (car (cdr branch)))

; 2)
(define (total-weight mobile)
  (cond ((not (pair? mobile)) mobile)
	(else (+ (total-weight (branch-structure
				 (left-branch mobile)))
		 (total-weight (branch-structure
				 (right-branch mobile)))))))

; 3)
; (define (balanced? mobile)
;  (

(define a (make-mobile
	    (make-branch 1 2)
	    (make-branch 3 4)))
(define b (make-mobile
	    (make-branch 2 a)
	    (make-branch 4 a)))
