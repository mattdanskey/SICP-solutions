; Louis' program runs slower because it calculates `queen-cols` on every loop of the map across the rows
; rather than the original code's `enumerate-interval`. It's worse than board-size*T time, because
; queen-cols is recursive and (queen-cols (- k 1)) runs into the same issue another board-size times in this
; version of the code. This seems like board-size^board-size T at this point. 
