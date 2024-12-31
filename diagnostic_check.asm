
; 6502 Assembly program to generate a simple bar chart from a dictionary of data

    lda dictionary     ; Load address of dictionary into accumulator
    sta ptr            ; Store address in pointer

loop:
    lda (ptr), y       ; Load data from dictionary
    beq done           ; Exit loop if end of data is reached

    ; Print bar chart
    cmp #$20           ; Check if data is space character
    beq print_space    ; Skip printing if data is space
    jsr print_bar      ; Print bar for data

    iny                ; Increment index
    bne loop           ; Continue looping

done:
    rts                ; Return from subroutine

print_bar:
    tay                ; Transfer data to Y register
    ldx #$00           ; Initialize counter

print_loop:
    lda #$2A           ; Load "*" character
    jsr $FFD2          ; Call routine to print character

    inx                ; Increment counter
    cpx y              ; Compare counter with data
    bcc print_loop     ; Continue printing if not yet done

    rts                ; Return from subroutine

print_space:
    lda #$20           ; Load space character
    jsr $FFD2          ; Call routine to print character

    rts                ; Return from subroutine

dictionary:
    .byte $20, $05     ; Data to be charted
    .byte $20, $0A
    .byte $20, $08
    .byte $20, $04
    .byte $20, $06
    .byte $00           ; End of data marker

ptr:
    .word dictionary    ; Pointer to dictionary

    .org $FFD2          ; Output routine
    rts
