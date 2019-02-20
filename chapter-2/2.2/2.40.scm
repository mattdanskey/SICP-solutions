#lang sicp

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low
	    (enumerate-interval (+ low 1) high))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
	  (accumulate op 
		      initial 
		      (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (filter predicate seq)
  (cond ((null? seq) nil)
	((predicate (car seq))
	 (cons (car seq)
	       (filter predicate (cdr seq))))
	(else (filter predicate (cdr seq)))))

; inefficient, but coding myself to shake out some cobwebs
(define (prime? n)
  (define (square x) (* x x))
  (define (iter i j)
    (cond ((> j i) (iter (+ i 1) 2))
	  ((> (* 2 i) n) #t)
	  ((= (* i j) n) #f)
	  (else (iter i (+ j 1)))))
  (iter 2 2))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair)
	(cadr pair)
	(+ (car pair) (cadr pair))))

(define (oldprime-sum-pairs n)
  (map make-pair-sum
       (filter 
	 prime-sum?
	 (flatmap
	   (lambda (i)
	     (map (lambda (j) 
		    (list i j))
		  (enumerate-interval 
		    1 
		    (- i 1))))
	   (enumerate-interval 1 n)))))

(define (unique-pairs n)
  (flatmap 
    (lambda (i) (map (lambda (j) (list i j))
		     (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter 
	 prime-sum?
	 (unique-pairs n))))
