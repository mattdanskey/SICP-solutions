; A) Louis' procedure produces the list in reverse order
; because the just-squared number is put at the front of the
; answer list via the cons
; and so all the previously squared numbers now follow it
; instead of precede it.

; B) The "fix" does not work because now instead of the 
; nil termination signifier at the end of the list,
; there's a squared number, and the linked list is
; no longer a list, and the interpreter does not know
; what to do with it.

; One could do an `append` instead of a `cons` instead
; and turn the squared number into a `list` of one item
; to be able to feed it to append, and that would work--
; just with the overhead of making a list for each element.
