#lang sicp

; note: This exercise was the most confusingly worded one so far -- by far.

; Miller-Rabin test:
; n: prime number
; a: positive integer < n
; a^(n-1) mod n == 1 mod n if n is prime.

; a number n is not prime if there is a nontrivial square root of 1 mod n

; non-trivial square root of 1 mod n:
; a number not equal to 1 or n - 1 whose
; square is *congruent* to 1 mod n.

; congruent:
; two numbers mod x that are equal (e.g. 7 mod 6 and 1 mod 6 are both 1)

(define (test n)
  (test-iter n (- n 1)))

(define (test-iter n a)
  (cond ((> a 0)
         (if (test-prime n a)
            (test-iter n (- a 1))
            (report " not prime with `a` of " n a)))
        (else (display n) (display " prime") (newline))))
   
(define (test-prime n a)
  (cond ((= (remainder 1 n) (expmod a (- n 1) n))
         #t)
        (else #f)))
              
(define (expmod base exp n)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (check-square n (expmod base (/ exp 2) n))
          n))
        (else
         (remainder 
          (* base (expmod base (- exp 1) n))
          n))))

(define (check-square n a)
  (define (nontrivial-square n sq)
    (if (= (remainder 1 n) (remainder sq n))
      0
      sq))
  (if (not (or (= a 1) 
	       (= a (- n 1))))
    (nontrivial-square n (square a))
    (square a)))

(define (report msg n a)
  (display n)
  (display msg)
  (display a)
  (newline))


(define (square x) (* x x))

(define (even? x) (= (remainder x 2) 0))

; should be prime
(display "primes")
(newline)
(test 2)
(test 3)
(test 11)
(test 17)

(newline)

; now all properly detected as not prime
(display "Carmichael numbers")
(newline)
(test 561)
(test 1105)
(test 1729)
(test 2465)
(test 2821)
(test 6601)
