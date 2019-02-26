#lang sicp

(define (enumerate-interval start n)
  (if (> start n)
      nil
      (cons start (enumerate-interval (+ start 1) n))))

(define (filter predicate items)
  (cond ((null? items) nil)
	((predicate (car items))
	 (cons (car items) (filter predicate (cdr items))))
	(else (filter predicate (cdr items)))))

(define (accumulate op initial items)
  (if (null? items)
      initial
      (op (car items)
	  (accumulate op
		      initial
		      (cdr items)))))

(define (flatmap proc items)
  (accumulate append nil (map proc items)))

(define (any? predicate items)
  (not (null? (filter predicate items))))

(define empty-board nil)

(define (get-position col positions)
  (let ((found-positions (filter (lambda (x) (= col (cdr x)))
				 positions)))
    (if (not (null? (cdr found-positions))) ; found more than one
	(error "Something went terribly wrong! Only one position per column is valid. Got " found-positions)
	(car found-positions))))

(define (rest-of-positions col positions)
  (filter (lambda (x) (not (= col (cdr x))))
	  positions))

(define (adjoin-position new-row column rest-of-queens)
  (append rest-of-queens (list (cons new-row column))))

(define (same-row? x y)
  (= (car x) (car y))) 

(define (same-ascending-diagonal? x y)
  (= (- (car y) (car x))
     (- (cdr y) (cdr x))))

(define (same-descending-diagonal? x y)
  (= (+ (- (car y) (car x)) 
	(- (cdr y) (cdr x)))
     0))

(define (safe? column positions) 
  (let ((queen (get-position column positions))
	(other-queens (rest-of-positions column positions)))
    (not (any? (lambda (other-queen) 
		 (or (same-row? queen other-queen)
		     (same-ascending-diagonal? queen other-queen)
		     (same-descending-diagonal? queen other-queen)))
	       other-queens))))

(define (queens board-size)
  (define (queen-cols col) ; renamed `k` to `col` to make more sense
    (if (= col 0)
	(list empty-board)
	(filter
	  (lambda (positions) 
	    (safe? col positions))
	  (flatmap
	    (lambda (rest-of-queens)
	      (map (lambda (new-row)
		     (adjoin-position 
		       new-row 
		       col
		       rest-of-queens))
		   (enumerate-interval 
		     1 
		     board-size)))
	    (queen-cols (- col 1))))))
  (queen-cols board-size))

; for some visual QA
(define (print-queens board-size queens)
  (map (lambda (board)
	 (newline)
	 (display "board")
	 (newline)
	 (map (lambda (row)
		(map (lambda (col)
		       (if (any? (lambda (queen) (and (= row (car queen))
						      (= col (cdr queen))))
				 board)
			   (display " Q ")
			   (display " - ")))
		     (enumerate-interval 1 board-size))
		(newline))
	      (enumerate-interval 1 board-size)))
       queens)
  (newline)
  (display "finished"))
