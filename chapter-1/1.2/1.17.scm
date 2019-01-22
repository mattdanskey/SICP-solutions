#lang sicp


(define (double x) (* 2 x))

(define (halve x) (/ x 2))

(define (lin* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))


; logarithmic while *not* iterative:
(define (even? x) (= (remainder x 2) 0))

(define (l* a b)
  (l-iter a b))

(define (l-iter a b)
  (cond ((= b 0) 0)
        ((even? b) (double (l-iter a (halve b))))
        (else (+ a (l-iter a (- b 1))))))

(lin* 4 3)
(l* 4 3)

(lin* 2 2)
(l* 2 2)

(lin* 5 6)
(l* 5 6)

(lin* 15 15)
(l* 15 15)

(lin* 10 11)
(l* 10 11)
