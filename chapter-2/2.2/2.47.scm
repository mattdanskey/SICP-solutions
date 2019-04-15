#lang sicp
(#%require sicp-pict)

(define (make-frameL origin edge1 edge2)
  (list origin edge1 edge2))
(define (make-frameT origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (make-vect x y)
  (cons x y))

(define (origin-frameL frame)
  (car frame))
(define (edge1-frameL frame)
  (car (cdr frame)))
(define (edge2-frameL frame)
  (car (cdr (cdr frame))))

(define (origin-frameT frame)
  (car frame)) ; same as for list frame
(define (edge1-frameT frame)
  (car (cdr frame))) ;same as for list frame
(define (edge2-frameT frame)
  (cdr (cdr frame)))


;tests
(define lframe (make-frameL (make-vect 1 2) (make-vect 3 4) (make-vect 5 6)))
(origin-frameL lframe)
(edge1-frameL lframe)
(edge2-frameL lframe)

(define tframe (make-frameT (make-vect 1 2) (make-vect 3 4) (make-vect 5 6)))
(origin-frameT tframe)
(edge1-frameT tframe)
(edge2-frameT tframe)