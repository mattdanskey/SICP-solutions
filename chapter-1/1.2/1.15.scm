#lang sicp

(define (cube x) (* x x x))
(define (p x)
  (display "called") (newline)
  (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
   (if (not (> (abs angle) 0.1))
       angle
       (p (sine (/ angle 3.0)))))

;1) called 5 times with an input of 12.15 (counted the displays).
;2) seems like O(log(a)) after feeding in some different inputs