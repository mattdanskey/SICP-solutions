#lang sicp

(define (equal? list1 list2)
  (cond ((not (and (pair? list1) (pair? list2)))
	 (eq? list1 list2))
	((and (pair? (car list1)) (pair? (car list2)))
	 (and (equal? (car list1) (car list2))
	      (equal? (cdr list1) (cdr list2))))
	(else
	  (and (eq? (car list1) (car list2))
	       (equal? (cdr list1) (cdr list2))))))


(eq? #t
     (equal? '(this is a list)
	     '(this is a list)))

(eq? #f
     (equal? '(this is a lizard)
	     '(this is a list)))

(eq? #f
     (equal? '(this is a list)
	     '(this (is a) list)))

(eq? #t
     (equal? '(this (is (a list)))
	     '(this (is (a list)))))

(eq? #f
     (equal? '(this (is (a lizard)))
	     '(this (is (a list)))))
