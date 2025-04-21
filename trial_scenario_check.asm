
        .org $0200

START   LDX #$00      ; X = 0
        STX PTR       ; Initialize pointer
LOOP    LDA BUFFER,X  ; Load byte from buffer
        CMP #','$     ; Check for comma
        BEQ NEXT      ; If comma, go to next byte
        CMP #' '       ; Check for space
        BEQ DONE      ; If space, done
        JSR TOINT      ; Convert ASCII to integer
        JSR ADD        ; Add integer to sum
        INX            ; Increment pointer
        JMP LOOP      ; Repeat loop
NEXT    INX            ; Increment pointer
        JMP LOOP      ; Repeat loop
DONE    LDA SUM
        STA RESULT
        BRK

TOINT   CLC           ; Clear carry
        LDA BUFFER,X
        SEC           ; Set carry
        SBC #'0'       ; Convert from ASCII to integer
        RTS

ADD     CLC
        ADC RESULT     ; Add to sum
        STA SUM
        RTS

RESULT  .byte $00
SUM     .byte $00
PTR     .byte $00      ; Pointer to buffer
BUFFER  .byte $00, $31, $32, $33, $34, $2C, $35, $36, $2C, $37, $38, $39, $00 ; Example CSV file data

        .end
