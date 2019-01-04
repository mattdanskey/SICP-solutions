#lang sicp

; expmod takes the remainder each iteration, instead of just at the end
; as fast-expt does. This means fast-expt is squaring larger numbers
; on the way to the final output, which is slower if the numbers
; get large enough.

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base (expmod base (- exp 1) m))
          m))))

(define (square x) (* x x))

(define (even? x) (= (remainder x 2) 0)) 

(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n) 
         (square (fast-expt b (/ n 2))))
        (else 
         (* b (fast-expt b (- n 1))))))

(define (expmod2 base exp m)
  (remainder (fast-expt base exp) m))