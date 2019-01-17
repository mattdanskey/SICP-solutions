#lang sicp

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (make-rect ll-corner ur-corner)
  (cons ll-corner ur-corner))

(define (sel-ll rect)
  (car rect))

(define (sel-ur rect)
  (cdr rect))

(define (sel-lr rect)
  (make-point (x-point (sel-ur rect))
	      (y-point (sel-ll rect))))

(define (sel-ul rect)
  (make-point (x-point (sel-ll rect))
	      (y-point (sel-ur rect))))

(define (get-height rect)
  (- (y-point (sel-ul rect))
     (y-point (sel-ll rect))))

(define (get-width rect)
  (- (x-point (sel-lr rect))
     (x-point (sel-ll rect))))

(define (perimeter rect)
  (* 2 (+ (get-height rect)
	  (get-width rect))))

(define (area rect)
  (* (get-height rect)
     (get-width rect)))

(define (test perimeter area rect)
    (display (perimeter rect))
    (newline)
    (display (area rect))
    (newline))

(define (test1 a b x y)
  (test perimeter
	area
    	(make-rect
	  (make-point a b)
	  (make-point x y))))

; writing <foo>2 functions so the original impl 
; can exist at the same time.

(define (make-rect2 lower-left-point width height)
  (cons lower-left-point 
	(cons width height)))

; width/height pairs are not semantically points
; which is why I use car/cdr here
(define (get-height2 rect)
  (cdr (cdr rect)))

(define (get-width2 rect)
  (car (cdr rect)))

; only different from original because of the
; added 2s. In practice get-height and get-width
; would be changed instead of new ones written

(define (perimeter2 rect)
  (* 2 (+ (get-height2 rect)
	  (get-width2 rect))))

(define (area2 rect)
  (* (get-height2 rect)
     (get-width2 rect)))

(define (test2 x y width height)
  (test perimeter2
	area2
	(make-rect2 (make-point x y)
		    width
		    height)))

(display "test (0,0) (1,1)")
(newline)
(test1 0 0 1 1)
(test2 0 0 1 1)

(display "test (2,3) (10,7)")
(newline)
(test1 2 3 10 7)
(test2 2 3 8 4)
