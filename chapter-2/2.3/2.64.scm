#lang sicp

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (list->tree elements)
  (car (partial-tree
	 elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size
	      (quotient (- n 1) 2)))
	(let ((left-result
		(partial-tree
		  elts left-size)))
	  (let ((left-tree
		  (car left-result))
		(non-left-elts
		  (cdr left-result))
		(right-size
		  (- n (+ left-size 1))))
	    (let ((this-entry
		    (car non-left-elts))
		  (right-result
		    (partial-tree
		      (cdr non-left-elts)
		      right-size)))
	      (let ((right-tree
		      (car right-result))
		    (remaining-elts
		      (cdr right-result)))
		(cons (make-tree this-entry
				 left-tree
				 right-tree)
		      remaining-elts))))))))

; 1)
; partial-tree takes in an ordered list of elements and a size n of tree to make.
; It returns a pair: a tree of size n and the remaining elements passed in beyond n.
; Its base case returns an empty tree and the elements passed in.
; It creates a tree with the first entry being the middle (for odd) or just-left-of-middle element
; (for an even number of elements), and the left and right trees being constructed by
; recursive calls. The right tree is constructed from the elements left over from constructing
; the left tree. In a sense, the tree is sketched out all the way to the leaf nodes and then
; filled up from the bottom up.

; The list (1 3 5 7 9 11) as a tree created by list->tree is the following:
;          5
;        /   \
;       1     9
;       \    / \
;        3  7  11

; 2) 
; The order of growth of `list->tree` for a list of n elements is O(n) because it only visits each element once.
; It also uses cons once for each element and not, say, `append`.
