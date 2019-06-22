#lang sicp
(#%require sicp-pict)

;for ease of use in console
(define (p f n)
  (paint (f einstein n)))


;1) add some segments to the wave painter from 2.49
;...given the lack of smoothness in doing ex 2.49 with this setup, I am skipping this one.

;2) change corner-split (such as only using one copy of up/right split images instead of two)
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter 
                                (- n 1))))
        (let ((top-left up)
              (bottom-right right)
              (corner (corner-split painter 
                                    (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right 
                         corner))))))


;3) Modify square-limit that uses square-of-four to use the corners in a different pattern
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) 
                       (tr painter)))
          (bottom (beside (bl painter) 
                          (br painter))))
      (below bottom top))))

(define (square-limit painter n)
  (let ((combine4 
         (square-of-four identity
                         flip-horiz
                         flip-vert
                         rotate180)))
    (combine4 (corner-split painter n))))