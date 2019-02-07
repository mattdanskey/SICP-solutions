#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
	(accumulate op 
		    initial 
		    (cdr sequence)))))


(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    nil
    (cons (accumulate op init (map car seqs))
	  (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (r) 
	 (accumulate + 0 (accumulate-n * 1 (list r v))))
       m))

(define (transpose mat)
  (accumulate-n cons nil mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (rm)
	   (matrix-*-vector cols rm))
	 m)))

(define a (list (list 1 -1 2)
		(list 0 -3 1)))
(define b (list 2 1 0))
(define c (list (list 0 4 -2)
		(list -4 -3 0)))
(define d (list (list 0 1)
		(list 1 -1)
		(list 2 3)))

;(matrix-*-vector a b)
;(matrix-*-matrix c d)
