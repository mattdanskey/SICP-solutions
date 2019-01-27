#lang sicp

(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))

; 1)
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (car (cdr mobile)))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (car (cdr branch)))

; 2)
(define (total-weight structure)
  (cond ((not (pair? structure)) structure)
	(else (+ (total-weight (branch-structure
				 (left-branch structure)))
		 (total-weight (branch-structure
				 (right-branch structure)))))))

; 3)
; balanced? returns the combined weight of the branches
; so that the torque of branches made from sub mobiles
; make sense.
; If not balanced in any structure, balanced? returns #f.
(define (balanced? structure)
  (cond ((not (pair? structure)) structure)
	(else 
	  (let ; apparently there's a let*, but not introduced (yet?) 
	    ((left (left-branch structure))
	     (right (right-branch structure)))
	    (let
	       ((left-length (branch-length left))
		(right-length (branch-length right))
		(left-weight (balanced? (branch-structure left)))
		(right-weight (balanced? (branch-structure right))))
	       (cond ((not (and left-weight right-weight))
		       #f)
		      ((not (= (* left-length left-weight)
			       (* right-length right-weight)))
		       #f)
		      (else (+ left-weight right-weight))))))))

(define s (make-mobile
	    (make-branch 1 12)
	    (make-branch 3 4)))
(define a (make-mobile
	    (make-branch 1 2)
	    (make-branch 3 4)))
(define b (make-mobile
	    (make-branch 2 a)
	    (make-branch 4 a)))

(balanced? s)
(balanced? a)
(balanced? b)
(balanced? (make-mobile
	     (make-branch 2 s)
	     (make-branch 3 s)))
(balanced? (make-mobile
	     (make-branch 2 s)
	     (make-branch 2 s)))

;4) Just right-branch and branch-structure would need to be updated
; to remove the `car` calls
