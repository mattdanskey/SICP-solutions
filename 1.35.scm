#lang sicp

; from section 1.2.2, phi is:
; (* phi phi) = (+ phi 1)
; divide by phi and we have:
; phi = (+ 1 (/ 1 phi)

(define tolerance 0.00001)

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

;phi
(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)
