#lang sicp

; today I learned about the fundamental theorem
; of arithmetic

(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (divinate num a)
  (define (iter res n)
    (if (= 0 (remainder res a))
      (iter (/ res a) (+ n 1))
      n))
  (iter num 0))

(define (car num)
  (divinate num 2))

(define (cdr num)
  (divinate num 3))
