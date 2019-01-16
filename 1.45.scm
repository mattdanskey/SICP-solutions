#lang sicp

; newtons-method
(define tolerance 0.0001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
	next
	(try next))))
  (try first-guess))

(define (average x y)
  (/ (+ x y)
     2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (repeated f n)
  (define (iter i newf)
    (if (< i 2)
      newf
      (iter (- i 1) 
	    (lambda (x) (f (newf x))))))
  (iter n f))

(define (damp f n)
  (cond ((= n 0) f)
	((< n 0) (error "invalid input" n))
	(else (repeated (average-damp f) n))))

(define (pow x n)
  (cond ((< n 0) (error "not supported" n))
	((= n 0) 1)
	((= n 1) x)
	(else (* x (pow x (- n 1))))))

(define (make-fixed-fn x n)
  (lambda (a) (/ x (pow a (- n 1)))))

(define (foo x n d)
  (fixed-point 
    (damp (make-fixed-fn x n) d)	
    1.0))

; in my tests, only 4 and 5 roots need more than one average damp.
; This is obviously not expected behavior given how the
; question is worded. Moving on.

(foo 32768 15 1)
; ~ 2

