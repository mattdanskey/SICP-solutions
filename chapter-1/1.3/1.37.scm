#lang sicp

; 1)
(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 1)
      (/ (n i)
	 (+ (d i) result))
      (iter (- i 1) 
	    (/ (n i) 
	       (+ (d i) result)))))
  (iter k 0))

(define (test k)
  (cont-frac (lambda (i) 1.0)
	     (lambda (i) 1.0)
	     k))
; needs a k of 10 (with rounding up) to get to
; 4 decimal places of accuracy.
(test 10)
; 0.617977....


; 2) a recursive version of the above
(define (rcont-frac n d k)
  (define (rec i)
    (if (= i k)
      (/ (n i) (d i))
      (/ (n i) 
	 (+ (d i) (rec (+ i 1))))))
  (rec 1))

(define (testr k)
  (rcont-frac (lambda (i) 1.0)
	     (lambda (i) 1.0)
	     k))
(testr 10)
