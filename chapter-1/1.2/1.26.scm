#lang sicp

; it becomes O(n) instead of O(log n) because `(expmod base (/ exp 2) m)`
; gets calculated twice every time `exp` is even. With using a `square`
; procedure, it only gets calculated once when it is fed into `square`.
; The change is similar to using normal order evaluation with `square`
; instead of applicative order.