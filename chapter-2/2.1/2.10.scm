#lang sicp
(define (make-interval a b)
  (cons a b))
(define (lower-bound interval)
  (car interval))
(define (upper-bound interval)
  (cdr interval))

(define (sub-interval a b)
  (make-interval (- (lower-bound a)
		    (upper-bound b))
		 (- (upper-bound a)
		    (lower-bound b))))


(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
	(p2 (* (lower-bound x) (upper-bound y)))
	(p3 (* (upper-bound x) (lower-bound y)))
	(p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
		   (max p1 p2 p3 p4))))

; is spanning inclusive of zero?
(define (spans-zero x)
  (and (< (lower-bound x) 0)
       (> (upper-bound x) 0)))

(define (div-interval x y)
  (if (spans-zero y)
    (error "divisor spans zero")
    (mul-interval
      x
      (make-interval (/ 1.0 (upper-bound y))
		     (/ 1.0 (lower-bound y))))))
