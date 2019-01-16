#lang sicp
;recursive process version
(define (f-recursive n)
  (cond ((< n 3) n)
        (else (+ (f-recursive (- n 1))
                 (* 2 (f-recursive (- n 2)))
                 (* 3 (f-recursive (- n 3)))))))

(f-recursive 1)
(f-recursive 2)
(f-recursive 3)
(f-recursive 4)
(f-recursive 5)
(f-recursive 6)
(f-recursive 7)
(f-recursive 8)

;iterative process version
(define (f-iterative n)
  (f-iter n 0 1 2))

(define (f-iter n a b c)
  (if (= n 0) a
     (f-iter  (- n 1)
              b
              c
              (+ c (* 2 b) (* 3 a)))))

(f-iterative 1)
(f-iterative 2)
(f-iterative 3)
(f-iterative 4)
(f-iterative 5)
(f-iterative 6)
(f-iterative 7)
(f-iterative 8)