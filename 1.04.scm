#lang sicp

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; the expression (if (> b 0) + -) will return the appropriate procedure
; depending on the inputs. After evaluating it,
; the line reads (- a b) if b is negative
; and (+ a b) if it is positive.