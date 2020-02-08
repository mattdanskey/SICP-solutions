#lang sicp

; Modify `type-tag`, `contents`, and `attach-tag` so that ordinary numbers are Scheme numbers
; instead of a 'scheme-number type-tagged pair.

(define (attach-tag type-tag contents)
  (if (eq? type-tag 'scheme-number)
      contents
      (cons type-tag contents)))

(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
        ((pair? datum) (car datum))
        (else (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (cond ((number? datum) datum)
        ((pair? datum) (cdr datum))
        (else (error "Bad tagged datum -- CONTENTS" datum))))

(eq? (attach-tag 'scheme-number 2) 2)
(eq? (type-tag 3) 'scheme-number)
(eq? (contents 1) (contents (cons 'scheme-number 1)))
