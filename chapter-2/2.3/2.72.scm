; Q: Given a case with the relative frequencies as in exercise 2.71,
; what is the order of growth in the number of steps to encode a symbol?
; Give the order of growth (as a function of n) of the number of steps needed
; to encode the most frequent and least frequent symbols in the alphabet.

; A: 
; most frequent:  O(n), as `element-of-set?` is O(n) and gets called either once
;		  or twice to get to the left/right leaf with the most frequent symbol
;		  and encode-symbol does not call itself again.

; least frequent: `encode-symbol` gets called n-1 times to get to the leaf node,
;		  calling `element-of-set?` n or 2n times (giving O(n)) on each 
;                 `encode-symbol` call, which gives O(n*(n-1)), or more generally O(n^2).

; When checking my thoughts, Eli Bendersky pointed out that changing the sets of symbols
; at each node to be represented as binary trees would allow `element-of-set?` to become
; O(log n) instead of O(n). 
; https://eli.thegreenplace.net/2007/09/12/sicp-section-234
