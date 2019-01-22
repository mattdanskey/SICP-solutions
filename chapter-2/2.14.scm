#lang sicp

; The centers seem to be (roughly) equivalent
; but the width becomes more compressed with
; par2 as compared to par1

; dividing an interval by itself doesn't get perfectly (1, 1) either

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

(define (add-interval x y)
  (make-interval (+ (lower-bound x) 
                    (lower-bound y))
                 (+ (upper-bound x) 
                    (upper-bound y))))

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

(define (spans-zero x)
  (and (< (lower-bound x) 0)
       (> (upper-bound x) 0)))

(define (div-interval x y)
  (if (spans-zero y)
    (error "divisor spans zero")
    (mul-interval
      x
      (make-interval (/ 1.0 (upper-bound y))
		     (/ 1.0 (lower-bound y))))))

(define (par1 r1 r2)
  (div-interval 
   (mul-interval r1 r2)
   (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval 
     one
     (add-interval 
      (div-interval one r1) 
      (div-interval one r2)))))

(define a (make-center-percent 10 2))
(define b (make-center-percent 11 3))
(define c (make-center-percent 110 2))
(define d (make-center-percent 110 3))
