
; 6502 Assembly program to perform basic operations on a linked list

ORG $1000

; Define data structures
NODE_SIZE = 2
LIST_PTR = $FF
BUFFER = $200

; Main program
MAIN:
    LDX #0                  ; Initialize index register
    STX LIST_PTR            ; Initialize linked list pointer
    
    ; Add nodes to linked list
    LDA #1
    JSR ADD_NODE            ; Add node with value 1
    LDA #2
    JSR ADD_NODE            ; Add node with value 2
    LDA #3
    JSR ADD_NODE            ; Add node with value 3
    
    ; Print contents of linked list
    JSR PRINT_LIST
    
    ; Delete node from linked list
    LDA #2
    JSR DELETE_NODE         ; Delete node with value 2
    
    ; Print contents of linked list after deletion
    JSR PRINT_LIST
    
    RTS

; Function to add a node to the linked list
ADD_NODE:
    LDX LIST_PTR            ; Load linked list pointer
    INX                     ; Increase pointer to next available slot
    STX LIST_PTR            ; Update linked list pointer
    STA (LIST_PTR),Y        ; Store value in new node
    RTS                     ; Return
    
; Function to delete a node from the linked list
DELETE_NODE:
    LDX #0                  ; Initialize index register
LOOP:
    LDA (LIST_PTR),Y        ; Load value from current node
    CMP #$FF                ; Check if end of list
    BEQ END_LOOP            ; If end of list, exit loop
    
    CMP A                   ; Compare value with input
    BEQ DELETE              ; If value matches, delete node
    
    INX                     ; Increase index
    INY
    JMP LOOP
    
DELETE:
    LDX Y                   ; Load index to delete node
    LDA #$FF                ; Clear node value
    STA (LIST_PTR),Y
    RTS
    
END_LOOP:
    RTS
    
; Function to print contents of linked list
PRINT_LIST:
    LDX #0                  ; Initialize index register
PRINT_LOOP:
    LDA (LIST_PTR),Y        ; Load value from current node
    CMP #$FF                ; Check if end of list
    BEQ END_PRINT           ; If end of list, exit loop
    
    STA BUFFER,X            ; Store value in buffer
    INX                     ; Increase index
    INY                     
    JMP PRINT_LOOP
    
END_PRINT:
    LDX #0
PRINT_CHAR_LOOP:
    LDA BUFFER,X
    CMP #$FF
    BEQ END_PRINT_CHAR        ; If end of list, exit loop
    
    JSR $FFD2                ; Call ROM routine to print character
    INX
    JMP PRINT_CHAR_LOOP
    
END_PRINT_CHAR:
    RTS

END
