#lang sicp

(define (square x) (* x x))

(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude)
           (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else
            (error "Unknown op: MAKE-FROM-REAL-IMAG" op))))
  dispatch)

; implement the constructor `make-from-mag-ang` in message-passing style:
(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* r (cos a)))
          ((eq? op 'imag-part) (* r (sin a)))
          ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          (else
            (error "Unknown op: MAKE-FROM-MAG-ANG" op))))
  dispatch)


(define ri (make-from-real-imag 2 4))
(define ma (make-from-mag-ang (ri 'magnitude) (ri 'angle)))

(define (compare op)
  (display op)
  (newline)
  (display (ri op))
  (newline)
  (display (ma op))
  (newline)
  (newline))

(map compare '(real-part imag-part magnitude angle))
