#lang sicp

(define (lower-bound interval)
  (car interval))
(define (upper-bound interval)
  (cdr interval))
