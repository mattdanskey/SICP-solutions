#lang sicp
(#%require sicp-pict)

;for ease of use in console
(define (p f n)
  (paint (f einstein n)))

(define (right-split-old painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split-old painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))
