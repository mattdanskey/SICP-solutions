#lang sicp
(define (make-interval a b)
  (cons a b))
(define (lower-bound interval)
  (car interval))
(define (upper-bound interval)
  (cdr interval))

; the interval covers from the lower bound of a
; minus the upper of b up to the upper of a minus
; the lower of b, which are the lowest & highest
; cases respectively.

(define (sub-interval a b)
  (make-interval (- (lower-bound a)
		    (upper-bound b))
		 (- (upper-bound a)
		    (lower-bound b))))
