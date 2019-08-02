#lang sicp

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (tree->list tree)
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


(define (union-list-set set1 set2)
  (cond ((null? set1) set2)
	((null? set2) set1)
	(else
	  (let ((x1 (car set1)) (x2 (car set2)))
	    (cond ((= x1 x2) (cons x1 (union-list-set (cdr set1)
						 (cdr set2))))
		  ((< x1 x2) (cons x1 (union-list-set (cdr set1)
						 set2)))
		  ((> x1 x2) (cons x2 (union-list-set set1
						 (cdr set2)))))))))

(define (intersection-list-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
	(cond ((= x1 x2)
	       (cons x1 (intersection-list-set 
			  (cdr set1)
			  (cdr set2))))
	      ((< x1 x2) (intersection-list-set 
			   (cdr set1) 
			   set2))
	      ((< x2 x1) (intersection-list-set 
			   set1 
			   (cdr set2)))))))

(define (union-set set1 set2)
  (list->tree
    (union-list-set (tree->list set1)
		    (tree->list set2))))

(define (intersection-set set1 set2)
  (list->tree
    (intersection-list-set (tree->list set1)
			   (tree->list set2))))

(define (test list1 list2)
  (let ((tree1 (list->tree list1))
	(tree2 (list->tree list2)))
    (display (intersection-set tree1 tree2))
    (newline)
    (display (union-set tree1 tree2))
    (newline)))

(test '(1 2 3) '(2 3 4 5))
(test '(2 3) '(5 6))
(test '(2 4 6) '(1 3 4 5))

; union-set and intersection-set both convert to ordered lists, perform their operations, and then
; convert the result to a binary tree. This is O(n) because each step (coversion and whatnot)
; touch each element once and are O(n) themselves. It is addition instead of multiplication, so
; growth is still linear. If I had used tree->list-1 instead of tree->list-2 from exercise 2.63,
; which is not O(n), then these implementations of union-set and intersection-set would not be O(n).
