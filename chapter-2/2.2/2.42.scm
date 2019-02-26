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
    (accumulate op (+ initial (op (car items))) (cdr items))))

(define (flatmap op initial items)
  nil)

(define empty-board nil)
(define (safe? positions) nil)
(define (adjoin-position new-row row rest-of-queens) nil)


(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) 
           (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position 
                    new-row 
                    k 
                    rest-of-queens))
                 (enumerate-interval 
                  1 
                  board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))
