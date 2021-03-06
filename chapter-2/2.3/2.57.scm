#lang sicp

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) 
  (if (eq? (cdddr s) '())
      (caddr s)
      (cons '+ (cddr s))))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p)
  (if (eq? (cdddr p) '())
      (caddr p)
      (cons '* (cddr p))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))


(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
	((=number? a2 0) a1)
	((and (number? a1) (number? a2)) 
	 (+ a1 a2))
	(else (list '+ a1 a2))))


(define (make-product m1 m2)
  (cond ((or (=number? m1 0) 
	     (=number? m2 0)) 
	 0)
	((=number? m1 1) m2)
	((=number? m2 1) m1)
	((and (number? m1) (number? m2)) 
	 (* m1 m2))
	(else (list '* m1 m2))))

(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

(define (base e)
  (cadr e))

(define (exponent e)
  (caddr e))

(define (make-exponentiation base exponent)
  (cond ((=number? exponent 0) 1)
	((=number? exponent 1) base)
	(else (list '** base exponent))))

(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp)
	 (if (same-variable? exp var) 1 0))
	((sum? exp)
	 (make-sum (deriv (addend exp) var)
		   (deriv (augend exp) var)))
	((product? exp)
	 (make-sum
	   (make-product 
	     (multiplier exp)
	     (deriv (multiplicand exp) var))
	   (make-product 
	     (deriv (multiplier exp) var)
	     (multiplicand exp))))
	((exponentiation? exp)
	 (make-product 
	   (exponent exp) 
	   (make-exponentiation (base exp) 
				(make-sum (exponent exp) -1))))
	(else (error "unknown expression 
		     type: DERIV" exp))))

(define (test result expected)
  (if (not (equal? result expected))
      (error "expected " expected "got" result)))

;;tests!
;sums
(test (augend '(+ 1 2 3))
	'(+ 2 3)) 
(test (augend '(+ 1 2))
	2)
(test (deriv '(+ x 2) 'x)
	1)
(test (deriv '(+ (* x 3) (* x 2)) 'x)
	5)
;3+ terms
(test (deriv '(+ 2 3 x) 'x)
	1)
(test (deriv '(+ 1 2 x y) 'x)
	1)
(test (deriv '(+ (* x 3) (* x 2) (* x 4)) 'x)
	9)

;products
(test (deriv '(* x 2) 'x)
	2)
(test (deriv '(* x y) 'x) 'y)
(test (deriv '(* (* x 3) y) 'x)
	'(* 3 y))
;3+ terms
(test (deriv '(* x 2 3) 'x)
      '(* 2 3))
(test (deriv '(* 2 3 x) 'x)
      6)
(test (deriv '(* 2 3 4 x y) 'x)
      '(* 2 (* 3 (* 4 y))))

;exponentiation
(test (deriv '(** x 1) 'x)
     	1)
(test (deriv '(** x 2) 'x)
	'(* 2 x))
(test (deriv '(** x 3) 'x)
	'(* 3 (** x 2)))

