#lang sicp

(define (square x) (* x x)) 

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) 
         b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p) (square q))
                   (+ (square q) (* 2 p q))
                   (/ count 2)))
        (else 
         (fib-iter (+ (* b q) 
                      (* a q) 
                      (* a p))
                   (+ (* b p) 
                      (* a q))
                   p
                   q
                   (- count 1)))))

(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 6)
(fib 7)
(fib 8)
(fib 9)
(fib 10)


;a
; bq + aq + ap
;b
; bp + aq

; a^2
; bq + aq + ap
; (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
; bpq + aq^2 + bq^2 + aq^2 + apq + bpq + apq + ap^2
; aq^2 + aq^2 + apq + apq + ap^2 + bpq + bq^2 + bpq
; a(q^2 + q^2 + pq + pq + p^2) + b(pq + q^2 + pq)
; a(2q^2 + p^2 + 2pq) + b(q^2 + 2pq)
; q' = q^2 + 2pq
; solving for p'
; a(p' + q') ;to match the `a` pieces of the starting point
; a(2q^2 + p^2 + 2pq) ; from just above the q' line
; a(q^2 + 2pq) + a(q^2 + p^2)
; p' = q^2 + p^2

;b^2
; bp + aq
; (bp + aq)p + (bq + aq + ap)q
; bp^2 + apq + bq^2 + aq^2 + apq
; b(p^2 + q^2) + a(q^2 + 2pq)
; p' = p^2 + q^2
; q' = q^2 + 2pq


