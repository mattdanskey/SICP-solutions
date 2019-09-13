#lang sicp


; 1) Explain what was done 'above'
; 	The operations for dealing with specific operators were put into the 
;       table and now are gotten when needed. In other words, the procedure
;	was converted to using data directed dispatch.

; b) Why can't we assimilate the predicates `number?` and `variable?` into the data-directed dispatch?
;	They apply to all inputs, as well as filtering out the non-expressions before
;	the rest of the code dispatches based on type of expression. They can't be
;	in the dispatch because variables and numbers don't have type tags (operators
;	in this case). 

; 2) Write the procedures for derivs of sums and products and install them.

; pasting in implementation from Section 3.3.3 so I can test my solution.
; I much prefer being able to verify my work.

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable 
	      (assoc key-1 (cdr local-table))))
	(if subtable
	    (let ((record 
		    (assoc key-2 
			   (cdr subtable))))
	      (if record (cdr record) false))
	    false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable 
	      (assoc key-1 (cdr local-table))))
	(if subtable
	    (let ((record 
		    (assoc key-2 
			   (cdr subtable))))
	      (if record
		  (set-cdr! record value)
		  (set-cdr! 
		    subtable
		    (cons (cons key-2 value)
			  (cdr subtable)))))
	    (set-cdr! 
	      local-table
	      (cons (list key-1
			  (cons key-2 value))
		    (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
	    ((eq? m 'insert-proc!) insert!)
	    (else (error "Unknown operation: 
			 TABLE" m))))
			  dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

; the missing support code to make it all work from section 2.3:

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

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

; the provided code:

(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp) 
	 (if (same-variable? exp var) 
	     1 
	     0))
	(else ((get 'deriv (operator exp)) 
	       (operands exp) 
	       var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

; the original selectors for addends et al in the original expect the type-tag 
; to be there, so those have been tweaked below.

(define (addend s) (car s))
(define (augend s) (cadr s))

(define (multiplier p) (car p))
(define (multiplicand p) (cadr p))

; the new procedures and their installation

(define (derive-sum exp var)
  (make-sum (deriv (addend exp) var) 
	    (deriv (augend exp) var)))

(define (derive-product exp var)
  (make-sum
    (make-product
      (multiplier exp)
      (deriv (multiplicand exp) var))
    (make-product 
      (deriv (multiplier exp) var)
      (multiplicand exp))))


(put 'deriv '+ derive-sum)
(put 'deriv '* derive-product)

(define (test result expected)
  (if (equal? result expected)
      'pass
      (begin 
	(display "fail: expected ")
	(display expected)
	(display " got " )
	(display result)
	(newline))))

(test (deriv '(+ x 2) 'x)
      1)

(test (deriv '(* x x) 'x)
      '(+ x x)) ;unsimplified 2x, which is valid)

(test (deriv '(* x 2) 'x)
      2)

; 3) Choose any additional differentiation rule and install it:

(define (base e) (car e))
(define (exponent e) (cadr e))

(define (make-exponentiation base exponent)
  (cond ((=number? exponent 0) 1)
	((=number? exponent 1) base)
	(else (list '** base exponent))))

(define (derive-exponent exp var)
  (make-product 
    (exponent exp) 
    (make-exponentiation (base exp) 
			 (make-sum (exponent exp) -1))))

(put 'deriv '** derive-exponent)

(test (deriv '(** x 1) 'x)
      1)

(test (deriv '(** x 2) 'x)
      '(* 2 x))

(test (deriv '(** x 3) 'x)
      '(* 3 (** x 2)))

; 4) What changes would be needed if the procedures were indexed in the opposite way?
;	The call to `get` in the `deriv` procedure would need its arguments swapped.
;	If registering procedures is also changed, then the `put` calls will need to be
;	swapped as well.
