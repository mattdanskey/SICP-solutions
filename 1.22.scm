#lang sicp

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) (* x x))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) 
         n)
        ((divides? test-divisor n) 
         test-divisor)
        (else (find-divisor 
               n 
               (+ test-divisor 1)))))

(define (smallest-divisor n)
  (find-divisor n 2))

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

; the order of growth does indeed seem to be O(square root(n))
;> (search-for-primes 1000 3)
;1009 *** 2
;1013 *** 2
;1019 *** 2
;done searching
;> (search-for-primes 10000 3)
;10007 *** 7
;10009 *** 8
;10037 *** 7
;done searching
;> (search-for-primes 100000 3)
;100003 *** 22
;100019 *** 22
;100043 *** 22
;done searching
;> (search-for-primes 1000000 3)
;1000003 *** 69
;1000033 *** 69
;1000037 *** 69
;done searching
;> (square 2)
;4
;> (square 7)
;49
;> (square 22)
;484
;> (square 69)
;4761
 