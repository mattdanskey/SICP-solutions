#lang sicp

; maybe later
; though with a few examples it looks like
; adding the percentages gets in the ballpark

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

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) 
               (lower-bound y)))
        (p2 (* (lower-bound x) 
               (upper-bound y)))
        (p3 (* (upper-bound x) 
               (lower-bound y)))
        (p4 (* (upper-bound x) 
               (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define a (make-interval 1 2))
(define b (make-interval 2 3))
