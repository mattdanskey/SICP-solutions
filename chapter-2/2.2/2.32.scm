#lang sicp

(define (subsets s)
  (if (null? s)
    (list nil)
    (let ((rest (subsets (cdr s))))
      (append rest
	      (map (lambda (x) (cons (car s) x))
		   rest)))))

; more easily readable output
(define (p s)
  (for-each (lambda (x)
	      (display x)
	      (newline))
	    s))

(p (subsets (list 1 2 3)))

; It works by having `rest` be all the subsets without the first element,
; and then adding to that all of those sets with the first element added.
; It breaks down the problem by adding an additional combinatory item
; each time we come back up the call stack one step (after first going
; down calls to `subsets' to where nil is the only item and a list of
; nil is the only set).
