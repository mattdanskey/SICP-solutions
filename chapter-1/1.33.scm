#lang sicp

; Letting the filter return the null-value if false so that
; `(term a)` need not be evaluated multiple times -- prior habit
; would just be to make a variable to hold the value.


(define (filter-accumulate filter combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term (filter a))
	      (filter-accumulate filter combiner null-value term (next a) next b))))

; 1)
(define (prime-squares a b)
  (define (fil x) (if (prime? x) x 0))
  (filter-accumulate fil + 0 square a inc b))

;2)
(define (rel-prime-sum n)
  (define (identity x) x)
  (define (fil x) (rel-prime-filter x n))
  (filter-accumulate fil * 1 identity 1 inc n))

(define (rel-prime-filter a b)
    (define (rel-prime-iter i)
      (cond ((> (square i) a) a)
	    ((= 0 (remainder a i))
	     (if (= 0 (remainder b i))
	       1
	       (rel-prime-iter (inc i))))
	    (else (rel-prime-iter (inc i)))))
    (rel-prime-iter 2))

; miller-rabin prime test for part 1 of this exercise:
(define (prime? n)
  (test-iter n (- n 1)))

(define (test-iter n a)
  (cond ((> a 0)
         (if (test-prime n a)
            (test-iter n (- a 1))
	    #f))
	(else #t)))
   
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

(define (even? x) (= (remainder x 2) 0))

(define (square x) (* x x))
