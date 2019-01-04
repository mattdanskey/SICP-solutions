#lang sicp

; the new code runs in 2/3 of the time, and so is 50% faster rather than
; 100% faster. There's some added overhead such as an `if` check.

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) 
         n)
        ((divides? test-divisor n) 
         test-divisor)
        (else (find-divisor 
               n 
               (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (next n)
  (if (= 2 n)
      3
      (+ n 2)))

(define (square x) (* x x))

;some code from 1.22

(define (prime? n)
  (= n (smallest-divisor n)))

; altered to report the prime number found as well
(define (report-prime n elapsed-time)
  (display n)
  (display " *** ")
  (display elapsed-time)
  (newline))

; altered to return false if not prime so the calling procedure
; knows if a prime has been found
(define (start-prime-test n start-time)
  (if (prime? n)
       (report-prime n (- (runtime)
                       start-time))
      #f))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (even? x) (= (remainder x 2) 0)) 

(define (search-for-primes start left)
  ;so that we don't check for oddness every loop
  (if (even? start)
      (sfp-impl (+ start 1) left)
      (sfp-impl start left)))

(define (sfp-impl start left)
  (if (> left 0)
      (if (timed-prime-test start)
          (sfp-impl (+ start 2) (- left 1))
          (sfp-impl (+ start 2) left))
      (display "done searching")))

;> (search-for-primes 1000 3)
;1009 *** 2
;1013 *** 1
;1019 *** 2
;done searching
;> (search-for-p;rimes 10000
;                     3)
;10007 *** 5
;10009 *** 6
;10037 *** 4
;done searching
;> (search-for-primes 100000 3)
;100003 *** 14
;100019 *** 14
;100043 *** 13
;done searching
;> (search-for-primes 1000000 3)
;1000003 *** 42
;1000033 *** 42
;1000037 *** 42
;done searching