#lang sicp

(define (same-parity i . rest)
  (define (s result left mod)
    (cond ((null? left) result)
	  ((= mod (remainder (car left) 2))
	   (s (append result (list (car left)))
	      (cdr left)
	      mod))
	  (else (s result (cdr left) mod))))
  (s (list i) 
     rest
     (remainder i 2))) 



(same-parity 1 2 3 4 5)
(same-parity 2 3 4 5 6)
