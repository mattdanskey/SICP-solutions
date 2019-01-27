#lang sicp

(define (tree-map f tree)
  (map (lambda (sub)
	 (if (pair? sub)
	   (tree-map f sub)
	   (f sub)))
       tree))

(define (square x) (* x x))

(define (square-tree items)
  (tree-map square items))

(square-tree (list 1 2 3 4))
(square-tree (list 1 2 (list 3 4) (list 5 6)))


