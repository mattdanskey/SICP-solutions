; width of (a,b) + (c,d)
; width of (a + c, b + d)
; (/ (- (+ b d) (+ a c))
;    2)

; width of (a,b) plus width of (c,d)
; (+ (/ (- b a) 2)
;    (/ (- d c) 2))
; (/ (+ (- b a) (- d c))
;    2)
; (/ (- (+ b d) (+ a c))
;    2)
; and so the width of the sum of two 
; intervals is equivalent
; to the sum of the widths of two intervals

; It should be similar for subtraction, given
; the similarity of addition and subtraction
; in interval arithmetic

; Example for not being true for multiplication:
; interval a of (1, 2) width 0.5
; interval b of (4, 8) width 2
; interval c of (8, 12) width 2
; interval of a * b (4 16) width 6
; interval of a * c (8 24) width 8
; a*b and a*c have different widths, even though
; b and c have the same width. Thus the width of the
; product is not a function only of the widths
; of the intervals multiplied.
