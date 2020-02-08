#lang sicp

; Some background code:

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types -- APPLY-GENERIC"
            (list op type-tags))))))


; Louis tries to evaluate (magnitute z) with `z` being 3i + 4, which is a complex rectangular number.
; He gets a "No method for these types" error and Alyssa fixes it by adding the following lines:

(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

; Adding the lines above works to fix the call to (magnitude z) with a complex number by
; registering procedures to handle complex numbers. Without this, the call to `get` inside of
; `apply-generic` finds no procedure.

;; 3i + 4 in rectangular form looks like this as data:
;; (let (z (cons ('complex (cons 'rectangular (cons 4 3))))))

; The chain of calls is as follows:
(magnitude (cons ('complex (cons 'rectangular (cons 4 3)))))
(apply-generic 'magnitude (cons ('complex (cons 'rectangular (cons 4 3)))))
((get 'magnitude 'complex) (cons 'rectangular (cons 4 3)))
(apply-generic 'magnitude (cons 'rectangular (cons 4 3)))
((get 'magnitude 'rectangular) (cons 4 3))
(magnitude (cons 4 3))
(sqrt (+ (square (real-part (cons 4 3)))
         (square (imag-part (cons 4 3)))))


; Apply-generic is called twice for the call of (magnitude z).
; The generic `magnitude` called dispatches to `apply-generic`, which then finds Alyssa's
; `magnitude (which is the same as the initial call), which is called with the 'complex
; tag removed and the contents unwrapped, so the second call to `apply-generic` is called
; with a 'rectangular type-tag. The 'rectangular version of magnitude is gotten, and
; the final answer is computed.
