#lang sicp

(define (make-leaf symbol weight) (list 'leaf symbol weight))
(define (leaf? object) (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
	right
	(append (symbols left) (symbols right))
	(+ (weight left) (weight right))))

(define (left-branch
	  tree) (car
	  tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
	'()
	(let ((next-branch
		(choose-branch (car bits) current-branch)))
	  (if (leaf? next-branch)
	      (cons (symbol-leaf next-branch)
		    (decode-1 (cdr bits) tree))
	      (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
	((= bit 1) (right-branch branch))
	(else (error "bad bit: CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
	((< (weight x) (weight (car set))) (cons x set))
	(else (cons (car set)
		    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
	(adjoin-set (make-leaf (car pair)
			       (cadr pair))
		    ; symbol
		    ; frequency
		    (make-leaf-set (cdr pairs))))))

(define (encode message tree)
  (if (null? message)
      '()
      (append
	(encode-symbol (car message)
		       tree)
	(encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (let ((left (left-branch tree))
	(right (right-branch tree)))
    (cond ((element-of-set? symbol (symbols left))
	   (if (leaf? left)
	       (list 0)
	       (cons 0 (encode-symbol symbol left))))
	  ((element-of-set? symbol (symbols right))
	   (if (leaf? right)
	       (list 1)
	       (cons 1 (encode-symbol symbol right))))
	  (else (error "bad symbol: ENCODE-SYMBOL" symbol)))))

(define (element-of-set? x set)
  (cond ((null? set) false)
	((equal? x (car set)) true)
	(else (element-of-set? x (cdr set)))))


(define sample-tree
  (make-code-tree (make-leaf 'A 4)
		  (make-code-tree
		    (make-leaf 'B 2)
		    (make-code-tree
		      (make-leaf 'D 1)
		      (make-leaf 'C 1)))))


(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (if (null? (cddr leaf-set))
      (make-code-tree (car leaf-set) (cadr leaf-set))
      (successive-merge
	(adjoin-set (make-code-tree (car leaf-set) (cadr leaf-set))
		    (cddr leaf-set)))))

; tests
(define sample-pairs '((A 4) (B 2) (C 1) (D 1)))
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
(define unencoded-message '(A D A B B C A))
(define expected-tree
  (make-code-tree (make-leaf 'A 4)
		  (make-code-tree
		    (make-leaf 'B 2)
		    (make-code-tree
		      (make-leaf 'D 1)
		      (make-leaf 'C 1)))))

(equal? expected-tree (generate-huffman-tree sample-pairs))
(equal? (encode unencoded-message (generate-huffman-tree sample-pairs))
	sample-message)

(define rock-pairs '((a 2) (Get 2) (Sha 3) (Wah 1) (boom 1) (job 2) (na 16) (yip 9)))
(define rock-message
  (append '(Get a job)
	  '(Sha na na na na na na na na)
	  '(Get a job)
	  '(Sha na na na na na na na na)
	  '(Wah yip yip yip yip yip yip yip yip yip)
	  '(Sha boom)))

; A) How many bits are required for the encoding?
(define encoded-rock-message (encode rock-message (generate-huffman-tree rock-pairs)))
(display encoded-rock-message)
(length encoded-rock-message)
; 84 bits

; B) What is the smallest number of bits that would be needed to encode this song
;    if we used a fixed-length code for the eight-symbol alphabet?
; log 2 of 8 = 3, so three bits per character.
; 3 bits * 36 symbols = 108 bits.


