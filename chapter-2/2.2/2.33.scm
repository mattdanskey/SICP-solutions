#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

; 1)
(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y))
	      nil sequence))

; 2)
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

; 3)
(define (length sequence)
  (accumulate (lambda (x y) (inc y)) 0 sequence))
