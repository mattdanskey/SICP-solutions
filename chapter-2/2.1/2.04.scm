#lang sicp

;(car (cons x y))
;(car (lambda (m) (m x y)))
;((lambda (m) (m x y)) (lambda (p q) p))
;((lambda (p q) p) x y)
;((lambda (x y) x))
;x

; corresponding cdr implementation
(define (cdr z)
  (z (lambda (p q) q)))
