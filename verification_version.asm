
    ; Program to convert a decimal number to a fraction

    .org $0200  ; Start program at address $0200

    lda #10     ; Load the base for the fraction
    sta BASE    ; Store the base in memory

    lda #0      ; Initialize the numerator to 0
    sta NUMER   ; Store the numerator in memory

    ldx #0      ; Initialize the counter to 0

LOOP:
    lda VALUE   ; Load the decimal number from memory
    cmp #0      ; Compare it to 0
    beq EXIT    ; If it is 0, exit the loop

    jsr DIVIDE  ; Divide the decimal number by the base
    jmp LOOP    ; Repeat the loop

EXIT:
    ; Halt the program here

DIVIDE:
    sec         ; Set the carry flag
    lda VALUE   ; Load the decimal number
    sbc BASE    ; Subtract the base
    sta VALUE   ; Store the new value
    inc NUMER   ; Increment the numerator
    rts         ; Return from subroutine

BASE:
    .byte 0     ; Base variable in memory
NUMER:
    .byte 0     ; Numerator variable in memory
VALUE:
    .byte 27    ; Decimal number to convert

    .end
