#lang racket

; more or less phoned a friend to get around the issues sicp-pict
; has with making custom painters.
; https://github.com/slobodin/SICP/blob/master/ch2/ex2-49.scm

; saves answers as pngs

(require (lib "racket/draw"))
(require racket/class)

; 101 instead of 100 to not swallow border lines
(define target (make-bitmap 101 101))
(define dc (new bitmap-dc% [bitmap target]))

(define (make-vect x y)
  (cons x y))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

(define (add-vect a b)
  (make-vect (+ (xcor-vect a) (xcor-vect b))
             (+ (ycor-vect a) (ycor-vect b))))

(define (sub-vect a b)
  (make-vect (- (xcor-vect a) (xcor-vect b))
             (- (ycor-vect a) (ycor-vect b))))

(define (scale-vect s a)
  (make-vect (* (xcor-vect a) s)
             (* (ycor-vect a) s)))

(define (make-segment v1 v2)
  (cons v1 v2))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (my-draw-line start end)
  (send dc
        draw-line
        (xcor-vect start)
        (ycor-vect start)
        (xcor-vect end)
        (ycor-vect end)))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (my-draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

(define (mseg x1 y1 x2 y2)
  (make-segment (make-vect x1 y1) (make-vect x2 y2)))

(define (output painter filename)
  (send dc clear)
  (painter (make-frame (make-vect 0 0)
                       (make-vect 0 100)
                       (make-vect 100 0)))
  (send target save-file filename 'png))

; 1) outline of the frame
(define outline-shape
  (segments->painter (list (mseg 0 0 0 1)
                           (mseg 0 1 1 1)
                           (mseg 1 0 0 0)
                           (mseg 1 1 1 0))))

(output outline-shape "2.49-1.png")

; 2) an x
(define x-painter
  (segments->painter (list (mseg 0 0 1 1)
                           (mseg 0 1 1 0))))
(output x-painter "2.49-2.png")

; 3) a diamond
(define diamond-painter
  (segments->painter (list (mseg 0.5 0 0 0.5)
                           (mseg 0.5 0 1 0.5)
                           (mseg 1 0.5 0.5 1)
                           (mseg 0.5 1 0 0.5))))
(output diamond-painter "2.49-3.png")

; 4) the wave painter
; (stick figure with triangle head
; for time and bendy line reasons)
(define wave-painter
  (segments->painter (list
                      (mseg 0 .7 0 .3)
                      (mseg .3 .5 0 .7)
                      (mseg .3 .5 0 .3)
                      (mseg .3 .5 .4 .5)
                      (mseg .3 0 .4 .5)
                      (mseg .3 1 .4 .5)
                      (mseg .6 .5 .4 .5)
                      (mseg 1 .2 .6 .5)
                      (mseg 1 .8 .6 .5)
                      )))
(output wave-painter "2.49-4.png")