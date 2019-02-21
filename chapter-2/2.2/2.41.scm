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

(define (unique-triples n)
  (flatmap 
    (lambda (i)
      (map (lambda (pair) (cons i pair))
	   (flatmap 
	     (lambda (j) (map (lambda (k) (list j k))
			      (enumerate-interval 1 n)))
	     (enumerate-interval 1 n))))
    (enumerate-interval 1 n)))

(define (make-triple-sum triple)
  (list (car triple)
	(cadr triple)
	(cadr (cdr triple))
	(accumulate + 0 triple)))

(define (sum-triples n s)
  (map make-triple-sum
       (filter 
	 (lambda (triple) (= (accumulate + 0 triple) s))
	 (unique-triples n))))
