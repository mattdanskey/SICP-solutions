#lang sicp
(#%require sicp-pict)

(define (make-vect x y)
  (cons x y))
(define (xcor-vect v)
  (car v))
(define (ycor-vect v)
  (cdr v))

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1)
                (xcor-vect v2))
             (+ (ycor-vect v1)
                (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1)
                (xcor-vect v2))
             (- (ycor-vect v1)
                (ycor-vect v2))))

(define (scale-vect s v)
  (make-vect (* s
                (xcor-vect v))
             (* s
                (ycor-vect v))))

(define (make-segment start end)
  (cons start end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

;tests
(define my-seg (make-segment (make-vect 1 2) (make-vect 3 4)))
my-seg
(start-segment my-seg)
(end-segment my-seg)