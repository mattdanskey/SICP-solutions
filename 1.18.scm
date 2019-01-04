#lang sicp


(define (double x) (* 2 x))

(define (halve x) (/ x 2))

(define (lin* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))


(define (it* a b)
  (it-iter a b 0))

(define (it-iter a b x)
  (cond ((= b 1) (+ a x))
        ((= (remainder b 2) 0) (it-iter (double a) (halve b) x))
        (else (it-iter a (- b 1) (+ a x)))))

; version 2
(define (i2* a b)
  (i2-iter a b 0))

(define (i2-iter a b x)
  (cond ((= b 0) x)
        ((= (remainder b 2) 0) (i2-iter (double a) (halve b) x))
        (else (i2-iter a (- b 1) (+ a x)))))


(lin* 4 3)
(it* 4 3)
(i2* 4 3)

(lin* 2 2)
(it* 2 2)
(i2* 2 2)

(lin* 5 6)
(it* 5 6)
(i2* 5 6)

(lin* 15 15)
(it* 15 15)
(i2* 15 15)

(lin* 10 11)
(it* 10 11)
(i2* 10 11)
