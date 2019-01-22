#lang sicp

(define (make-rat num den)
  (cond ((> 0 den)
	 (cons (- 0 num) (- 0 den)))
	(else
	 (cons num den))))
