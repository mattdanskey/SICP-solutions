#lang sicp

(define (repeated f n)
  (define (iter i newf)
    (if (= i 1)
      newf
      (iter (- i 1) 
	    (lambda (x) (f (newf x))))))
  (iter n f))

(define (smooth f)
  (let ((dx 0.0001)) 
    (lambda (x) (/ (+ (f (- x dx))
		      (f x)
		      (f (+ x dx)))
		   3))))

(define (n-fold-smooth f n)
  (repeated (smooth f) n))
