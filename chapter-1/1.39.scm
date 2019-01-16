#lang sicp

(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 1)
      (/ (n i)
	 (+ (d i) result))
      (iter (- i 1) 
	    (/ (n i) 
	       (+ (d i) result)))))
  (iter k 0))

; able to still use cont-frac by making the numerator
; negative beyond k of 1
(define (tan-cf x k)
  (cont-frac (lambda (i) (if (= i 1)
			   x
			   (- (* x x))))
	     (lambda (i) (- (* 2.0 i) 1))
	     k))
