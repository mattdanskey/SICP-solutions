#lang sicp


; professional answer:
; "That may be possible, Ben.
; I wouldn't recommend it given
; how much less readable the code becomes."

(define (make-interval a b)
  (if (> a b)
    ; this problem becomes simpler when one doesn't try to
    ; entertain nonensical possibilities
    (error "lower bound cannot be a higher value than upper bound" a b))
  (cons a b))
(define (lower-bound interval)
  (car interval))
(define (upper-bound interval)
  (cdr interval))


(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
	(p2 (* (lower-bound x) (upper-bound y)))
	(p3 (* (upper-bound x) (lower-bound y)))
	(p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
		   (max p1 p2 p3 p4))))

(define (show x y a b)
  (print-i (mul-interval (make-interval x y)
			 (make-interval a b)))
  (print-i (new-mul (make-interval x y)
		    (make-interval a b))))

; nested cons are not so readable.
; Needing comments is a sign of that.
(define (new-mul x y)
  (let ((lx (lower-bound x))
	(ux (upper-bound x))
	(ly (lower-bound y))
	(uy (upper-bound y)))
    (cond ((>= lx 0) ; x: (+, +)
	   (cond ((>= ly 0) ; y: (+, +) 
		  (make-interval (* lx ly) (* ux uy)))
		 ((>= uy 0) ; y: (-, +)
		  (make-interval (* ux ly) (* ux uy)))
		 (else ; y: (-, -)
		   (make-interval (* ux ly) (* lx uy)))))
	  ((>= ux 0) ; x: (-, +)
	   (cond ((>= ly 0)
		  (make-interval (* lx uy) (* ux uy)))
		 ((>= uy 0)
		  (make-interval (min (* lx uy) (* ux ly))
				 (max (* lx ly) (* ux uy))))
		 (else 
		   (make-interval (* ux ly) (* lx ly)))))
	  (else ; x: (-, -)
	    (cond ((>= ly 0)
		   (make-interval (* lx uy) (* ux ly)))
		  ((>= uy 0)
		   (make-interval (* lx uy) (* lx ly)))
		  (else 
		    (make-interval (* ux uy) (* lx ly))))))))


(define (ieq x y)
  (and (= (lower-bound x) (lower-bound y))
       (= (upper-bound x) (upper-bound y))))

(define (print-i i desc)
  (display desc)
  (display ": (")
  (display (lower-bound i))
  (display ", ")
  (display (upper-bound i))
  (display ") ")
  (newline))

(define (test x y a b)
  (let ((old (mul-interval (make-interval x y)
			   (make-interval a b)))
	(new (new-mul (make-interval x y)
		      (make-interval a b))))
    (if (not (ieq old new))
	   (begin 
	     (display "Test failed.")
	     (newline)
	     (print-i old "old") 
	     (print-i new "new")
	     (error "Old and new do not match \n" "x y a b: " x y a b))
	   (display "passed"))))

(test 1 2 1 2)
(test 1 2 -1 2)
(test 1 2 -2 -1)

(test -1 2 1 2)
(test -1 2 -1 2)
(test -10 1 -11 1)
(test -10 1 -11 2)
(test -1 2 -2 -1)

(test -2 -1 1 2)
(test -2 -1 -1 2)
(test -2 -1 -2 -1)
