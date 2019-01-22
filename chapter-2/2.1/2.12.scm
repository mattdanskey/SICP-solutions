#lang sicp

(define (make-interval a b)
  (cons a b))
(define (lower-bound i)
  (car i))
(define (upper-bound i)
  (cdr i))

(define (center i)
  (/ (+ (lower-bound i)
	(upper-bound i))
     2))

(define (width i)
  (/ (- (upper-bound i)
	(lower-bound i))
     2))

(define (percent i)
  (* 100.0 (/ (width i) (center i))))

(define (make-center-percent c percent)
  (make-interval (- c (* c (/ percent 100.0)))
		 (+ c (* c (/ percent 100.0)))))



(define a (make-interval 2.5 7.5))
(define b (make-center-percent 5 50))
(center a)
(center b)
(width a)
(width b)
(percent a)
(percent b)
