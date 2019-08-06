#lang sicp

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

; the record only needs to be the key at the moment, but only this
; function would need to change in the future
(define (key record)
  record)

(define (lookup given-key set-of-records)
  (if (null? set-of-records)
      false
      (let ((entry-key (key (entry set-of-records))))
	(cond ((equal? given-key entry-key)
	       (entry set-of-records))
	      ((< given-key entry-key)
	       (lookup given-key (left-branch set-of-records)))
	      ((> given-key entry-key)
	       (lookup given-key (right-branch set-of-records)))))))


;basic tests
(define set1 '(4 (1 () ()) (6 () ())))
(define set2 '(4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (8 (7 () ()) (9 () ())))))

(equal? #false (lookup 5 set1))
(equal? 4 (lookup 4 set1))
(equal? 1 (lookup 1 set1))
(equal? 6 (lookup 6 set1))

(equal? #false (lookup 10 set2))
(equal? 7 (lookup 7 set2))
(equal? 1 (lookup 1 set2))
