#lang sicp

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(list 1 (list 2 (list 3 4)))

; (1 (2 (3 4)))
; output from Racket:
; (mcons 1 (mcons (mcons 2 (mcons (mcons 3 (mcons 4 '())) '())) '()))

; ascii attempt of pointer diagram:
;
; [ 1 | * ]
;       |
;   [ 2 | * ]
;         |
;     [ 3 | * ]
;           |
;       [ 4 | nil ]

; ascii attempt of tree
;
;      * (1 (2 (3 4)))
;     / \
;    1   * (2 (3 4))
;       / \
;      2   * (3 4)
;         / \
;        3   4
