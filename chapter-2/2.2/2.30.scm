#lang sicp

; w/o higher-order procedures
(define (square-tree items)
  (cond 
    ((null? items) nil)
    ((not (pair? items)) (* items items))
    (else (cons (square-tree (car items))
		(square-tree (cdr items))))))

;with map
(define (smap-tree items)
  (map (lambda (sub)
	 (if (pair? sub) 
	   (smap-tree sub)
	   (* sub sub)))
       items))

(square-tree (list 1 2 3 4))
(square-tree (list 1 2 (list 3 4) (list 5 6)))


(smap-tree (list 1 2 3 4))
(smap-tree (list 1 2 (list 3 4) (list 5 6)))
