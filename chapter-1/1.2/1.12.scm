#lang sicp

(define (pascal row col)
  ;prevent infinite loop for invalid inputs
  (if (or (< col 1) (< row 1))
      0
      (cond ((or (= col 1) (= col row)) 1)
            (else (+ (pascal (- row 1) (- col 1))
                     (pascal (- row 1) col))))))