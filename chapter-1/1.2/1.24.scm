#lang sicp

; it's pretty comparable, which is expected for O(log n) growth. It's only
; roughly double the time for primes near 1,000,000 as compared to primes
; near 1,000

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

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) 
         (fast-prime? n (- times 1)))
        (else false)))


(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) (* x x))

; altered to report the prime number found as well
(define (report-prime n elapsed-time)
  (display n)
  (display " *** ")
  (display elapsed-time)
  (newline))

; altered to return false if not prime so the calling procedure
; knows if a prime has been found
(define (start-prime-test n start-time)
  (if (fast-prime? n 3)
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

;> (search-for-primes 1000000 3)
;1000003 *** 12
;1000033 *** 10
;1000037 *** 11
;done searching
;> (search-for-primes 100000 3)
;100003 *** 9
;100019 *** 8
;100043 *** 9
;done searching
;> (search-for-primes 10000 3)
;10007 *** 12
;10009 *** 14
;10037 *** 11
;done searching
;> (search-for-primes 1000 3)
;1009 *** 6
;1013 *** 6
;1019 *** 6
;done searching
 