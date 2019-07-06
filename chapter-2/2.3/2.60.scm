#lang sicp

; slower (checking through a longer list)
(define (element-of-set? x set)
  (cond ((null? set) false)
	((equal? x (car set)) true)
	(else (element-of-set? x (cdr set)))))

; faster
(define (adjoin-set x set)
  (cons x set))

; slower (longer lists)
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) 
	 '())
	((element-of-set? (car set1) set2)
	 (cons (car set1)
	       (intersection-set (cdr set1) 
				 set2)))
	(else (intersection-set (cdr set1) 
				set2))))

; slower (longer lists)
(define (union-set set1 set2)
  (append set1 set2))

(equal? (union-set '(1 2 3) '(3 4 5))
	'(1 2 3 3 4 5))

(equal? (union-set '(1 3 4) '(1 2 4))
	'(1 3 4 1 2 4)) 

; This alternate representation seems to be most suited to situations where there is a lot of adjoining and unions, but much less checking for specific elements or finding intersections of sets. It would also use more memory. 
