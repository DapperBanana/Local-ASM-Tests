
ORG $0200

START
    LDX #$00        ; Initialize index
    STX CURRENT_PTR ; Set current pointer to NULL

    ; Add elements to the linked list
    LDA #5
    JSR ADD_TO_LIST
    LDA #10
    JSR ADD_TO_LIST
    LDA #15
    JSR ADD_TO_LIST

    ; Print the linked list
PRINT_LIST
    LDX CURRENT_PTR
    BEQ END_PRINT

PRINT_LOOP
    LDA (X)
    JSR PRINT_VALUE
    INX
    CPX #0xFF        ; Check for end of list
    BNE PRINT_LOOP

END_PRINT

    ; Remove an element from the linked list
    LDX #$00
REMOVE_LOOP
    LDA (X)
    CMP #10          ; Check if element is 10
    BEQ REMOVE_ELEM
    INX
    CPX #0xFF
    BNE REMOVE_LOOP

    ; Couldn't find element 10
REMOVE_ELEM
    BNE END_REMOVE

    ; Remove element from list
    LDX CURRENT_PTR
    BEQ END_REMOVE

REMOVE_LOOP2
    INX
    LDA (X)
    CMP #10
    BNE REMOVE_LOOP2

    LDX CURRENT_PTR
    STX (X)
    JMP END_REMOVE

END_REMOVE

    BRK             ; End program

; Subroutine to add an element to the linked list
ADD_TO_LIST
    LDX CURRENT_PTR
    BEQ FIRST_ELEM

ADD_LOOP
    LDA (X)
    CPX #0xFF        ; Check for end of list
    BNE ADD_LOOP

    STA ELEM_VAL
    STA (X)
    INX
    STX CURRENT_PTR
    JMP END_ADD

FIRST_ELEM
    STA ELEM_VAL
    STA $0200
    INX
    STX CURRENT_PTR

END_ADD
    RTS

; Subroutine to print a value
PRINT_VALUE
    JSR CONVERT_TO_ASCII
    LDA ELEM_VAL
    JSR $FFD2 ; Kernal routine for printing character

    RTS

; Subroutine to convert value to ASCII
CONVERT_TO_ASCII
    LSR
    LSR
    LSR
    LSR
    ORA #$30

    STA ELEM_VAL

    RTS

CURRENT_PTR .BYTE $FF
ELEM_VAL    .BYTE $00

.END
