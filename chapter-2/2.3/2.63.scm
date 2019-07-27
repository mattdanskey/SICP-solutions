#lang sicp

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append 
	(tree->list-1 
	  (left-branch tree))
	(cons (entry tree)
	      (tree->list-1 
		(right-branch tree))))))


(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
	result-list
	(copy-to-list 
	  (left-branch tree)
	  (cons (entry tree)
		(copy-to-list 
		  (right-branch tree)
		  result-list)))))
  (copy-to-list tree '()))

(define tree-1 (make-tree 7 
			  (make-tree 3 
				     (make-tree 1 '() '()) 
				     (make-tree 5 '() '()))
			  (make-tree 9 
				     '() 
				     (make-tree 11 '() '()))))

(define tree-2 (make-tree 3
			  (make-tree 1 '() '())
			  (make-tree 7
				     (make-tree 5 '() '())
				     (make-tree 9
						'()
						(make-tree 11 '() '())))))

;can also use a quote to put in a list literal
(define tree-3 '(5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ()))))

(define (compare tree)
  (display (tree->list-1 tree))
  (newline)
  (display (tree->list-2 tree))
  (newline))

;1)
;The procedures return the same results.
;The lists appear the same for the two trees in Figure 2.16:
(compare tree-1)
(compare tree-2)
(compare tree-3)

;2)
;Both procedures touch each node of the binary tree once, for O(n) growth.
;The caveat is that append as defined in section 2.2.1, when fed two halves of a tree in tree->list-1,
;slows down the procedure by O(log n) time, as append is cons called recursively.
;Thus tree->list-1 is O(n*log n) and tree->list-2 is O(n)
;https://billthelizard.blogspot.com/2013/03/sicp-263-265-sets-as-binary-trees.html
