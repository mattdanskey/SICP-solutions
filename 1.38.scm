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

(define (e-approx k)
  (cont-frac (lambda (x) 1)
	     (lambda (x)
	       (let ((y (+ x 1)))
		 (if (= 0 (remainder y 3))
		   (* y (/ 2.0 3))
		   1)))
	     k))

(e-approx 5)
