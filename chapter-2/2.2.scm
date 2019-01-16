#lang sicp

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (make-segment a b)
  (cons a b))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))

(define (midpoint-segment seg)
  (make-point (/ (+ (x-point (start-segment seg))
		    (x-point (end-segment seg)))
		 2.0)
	      (/ (+ (y-point (start-segment seg))
		    (y-point (end-segment seg)))
		 2.0)))

(define (test a b x y)
  (print-point
    (midpoint-segment
      (make-segment (make-point a b)
		    (make-point x y)))))
