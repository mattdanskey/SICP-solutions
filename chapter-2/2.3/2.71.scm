; n = 5
;
; (a b c d e) 31
; - (e) 16
; - (a b c d) 15
;   - (d) 8
;   - (a b c) 7
;     - (c) 4
;     - (a b) 3 
;       - (a 1)
;       - (b 2)

; n = 10
;
; (a b c d e f g h i j) 1023
; - (j) 512
; - (a b c d e f g h i) 511
;   - (i) 256
;   - (a b c d e f g h) 255
;     - (h) 128
;     - (a b c d e f g) 127
;       - (g) 64
;       - (a b c d e f) 63
;         - (f) 32
;         - (a b c d e) 31
;           - (e) 16
;           - (a b c d) 15
;             - (d) 8
;             - (a b c) 7
;               - (c) 4
;               - (a b) 3 
;                 - (a 1)
;                 - (b 2)

; Q: How many bits for the most frequent symbol?
; A: one.

; Q: How many bits for the least frequent?
; A: n - 1