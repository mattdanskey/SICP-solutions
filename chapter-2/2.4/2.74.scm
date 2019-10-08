#lang sicp

; handy test function
(define (test result expected)
  (if (equal? result expected)
      'pass
      (begin 
        (display "fail: expected ")
        (display expected)
        (display " got " )
        (display result)
        (newline))))

; It doesn't get much more data-driven than the data declaring how to
; access itself. The personell files would need to supply the shape
; of the data that needs to be accessed. For the sake of this exercise,
; I chose to accomplish this by having procedures ; in the file under 
; standardized tag of 'operations and standardized operation names.

; These operations are analogous to stored procedures in a database, and
; similarly one would want to have security measures around updating the operations.


; some helper procedures that might be in an internal library
; or placed in the files as needed:
(define (shallow-find tag items)
  (cond ((null? items) #false)
        ((eq? tag (caar items)) (car items))
        (else (shallow-find tag (cdr items)))))

(define (get-list-by-tag tag items)
  (let ((item (shallow-find tag items)))
    (if item
        (cdr item)
        #false)))

(define (get-value-by-tag tag items)
  (let ((item (shallow-find tag items)))
    (if item
        (cadr item)
        #false)))

(define (get-value-from-record tag record)
  (cond ((not (pair? record)) #false)
        ((eq? (caar record) tag) (cadar record))
        (else (get-value-from-record tag (cdr record)))))

; basically reimplemented `assoc`, which hasn't been introduced
(define (find-record-by-value tag value records) 
  (cond ((null? records) #false)
        ((eq? value (get-value-from-record tag (car records))) (car records))
        (else (find-record-by-value tag value (cdr records)))))


; division operations - the same stucture across divisions in the interest of time.
(define (get-employee-operation division)
  (lambda (name)
    (find-record-by-value
      'name
      name
      (get-list-by-tag 'employees division))))

(define (get-salary-operation division)
  (lambda (name)
    (get-value-from-record
      'salary
      (find-record-by-value
        'name
        name
        (get-list-by-tag 'employees division)))))

; the division files
(define division-a
  (list
    (list 'operations
          (list 'get-employee (get-employee-operation division-a))
          (list 'salary (get-salary-operation division-a)))
    (list 'employees
          '((name "Jane Doe") (salary 650))
          '((name "John Smith") (salary 630)))))

(define division-b
  (list
    (list 'operations
          (list 'get-employee (get-employee-operation division-b))
          (list 'salary (get-salary-operation division-b)))
    (list 'employees
          '((name "Bill Burnquist") (salary 499))
          '((name "Jill Jurnquist") (salary 700)))))

(define (get-operation op division-file)
  (get-value-by-tag
    op
    (get-list-by-tag 'operations division-file)))

; 1) implement a get-record procedure
(define (get-record name division-file)
  ((get-operation 'get-employee division-file) name))

(test (get-record "No Treal" division-a)
      #false)
(test (get-record "Jane Doe" division-a)
      '((name "Jane Doe") (salary 650)))
(test (get-record "Jill Jurnquist" division-b)
      '((name "Jill Jurnquist") (salary 700)))

; 2) implement a get-salary procedure
(define (get-salary name division-file)
  ((get-operation 'salary division-file) name))

(test (get-salary "John Smith" division-a)
      630)
(test (get-salary "Who am I really?" division-b)
      #false)
(test (get-salary "Bill Burnquist" division-b)
      499)

; 3) implement a find-employee-record procedure that searches all divisions' files
(define (find-employee-record name divisions)
  (if (null? divisions)
      #false
      (let ((record (get-record name (car divisions))))
        (if record
            record
            (find-employee-record name (cdr divisions))))))

(test (find-employee-record "Mist and Shadow" (list division-a division-b))
      #false)
(test (find-employee-record "Jane Doe" (list division-a division-b))
      '((name "Jane Doe") (salary 650)))
(test (find-employee-record "Jill Jurnquist" (list division-a division-b))
      '((name "Jill Jurnquist") (salary 700)))

; 4) What changes must be made to incorporate a new division when Insatiable
;    takes over a company?

; The division would need to add in approprately tagged operations
; into its personnel file for accessing the data contained therein.
; The division file would then need to be added into the list of files.
; The procedures applicable to all files would be unchanged.