;a) What must be changed to add new types or operations with
;the strategy of generic operations with explicit dispatch?
;   
; To add new types, every single operation must be changed
; to explicitly call the procedure made for the new type.
;
; To add new operations, the implementations to handle each type
; need to be created, but existing operations
; would be left untouched.


;b) What must be changed to add new types or operations with
;the strategy of data-directed style?
;
; To add new types, implementations for each operation would
; need to be created and registered.
;
; To add new operations, a generic procedure and the implementations
; for each type would need to be created, and the impls registered.


;c) What must be changed to add new types or operations with
; the strategy of message-passing?
;
; To add a new type, the constructor needs to be created, which
; would implement all the operations needed.
;
; To add a new operation, every type would need to be altered to
; support it (assuming the operation is a universal one).


;d) Which would be most appropriate when new types must often be added?
;
; Message-passing and data-directed programming both allow for new types
; to be added without changing existing implementations.


;e) Which would be most appropriate when new operations must often be added?
;
; Explicit dispatch and data-directed programming allow for new operations
; without altering existing code.