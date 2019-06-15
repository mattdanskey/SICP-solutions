#lang racket
(#%require sicp-pict)

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left  (transform-painter 
                        painter1
                        (make-vect 0.0 0.0)
                        split-point
                        (make-vect 0.0 1.0)))
          (paint-right (transform-painter
                        painter2
                        split-point
                        (make-vect 1.0 0.0)
                        (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

(define (simple-transform painter origin v1 v2)
  (lambda (frame)
    ((transform-painter
      painter
      origin
      v1
      v2)
     frame)))

(define (flip-horiz painter)
  (simple-transform
   painter
   (make-vect 0 1)
   (make-vect 1 1)
   (make-vect 0 0)))


(define (rotate-180 painter)
  (simple-transform
   painter
   (make-vect 1 1)
   (make-vect 0 1)
   (make-vect 1 0)))

(define (rotate-270 painter)
  (simple-transform
   painter
   (make-vect 1 0)
   (make-vect 1 1)
   (make-vect 0 0)))

;(paint einstein)
;(paint (flip-horiz einstein))
;(paint (rotate-180 einstein))
;(paint (rotate-270 einstein))
