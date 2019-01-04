#lang sicp

(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n) 
         (square (fast-expt b (/ n 2))))
        (else 
         (* b (fast-expt b (- n 1))))))


(define (even? n)
  (= (remainder n 2) 0))

(define (square x) (* x x))

(define (iter-exp b n)
  (ie-iter b n 1))

(define (ie-iter base exp a)
  (cond ((< exp 1) 1)
        ;maybe deal with negative exponents properly at some point
        ((= exp 1) (* a base))
        ((even? exp) (ie-iter (square base)
                              (/ exp 2)
                              a))
        (else (ie-iter base
                       (- exp 1)
                       base))))

; alternative version
(define (iter2-exp b n)
  (ie2-iter b n 1))
(define (ie2-iter b n a)
  (cond ((= 0 n) a)
        ((even? n) (ie2-iter (square b) (/ n 2) a))
        (else (ie2-iter b (- n 1) (* a b)))))

(fast-expt 3 2)
(iter-exp 3 2)
(iter2-exp 3 2)

(fast-expt 4 3)
(iter-exp 4 3)
(iter2-exp 4 3)

(fast-expt 2 3)
(iter-exp 2 3)
(iter2-exp 2 3)

(fast-expt 2 5)
(iter-exp 2 5)
(iter2-exp 2 5)

(fast-expt 2 8)
(iter-exp 2 8)
(iter2-exp 2 8)

(fast-expt 5 1)
(iter-exp 5 1)
(iter2-exp 5 1)

