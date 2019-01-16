#lang sicp

(define (test-carms n)
  (carms-iter n (- n 1)))

(define (carms-iter n a)
  (cond ((> a 0)
         (if (test-prime n a)
            (carms-iter n (- a 1))
            (report " not prime with a of " n a)))
        (else (display n) (display " prime") (newline))))
   
(define (test-prime n a)
  (cond ((= (remainder a n) (expmod a n n))
         #t)
        (else #f)))
              
(define (report msg n a)
  (display n)
  (display msg)
  (display a)
  (newline))

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

(test-carms 561)
(test-carms 1105)
(test-carms 1729)
(test-carms 2465)
(test-carms 2821)
(test-carms 6601)