
        .org $0200
number  .byte $0F, $9F, $8A, $5C ; Example numbers to check
        .byte $00 ; Buffer for storing digits

start   ldx #0             ; Initialize index
check   lda number, x      ; Load the current number
        cmp #$00           ; Check if end of list
        beq end            ; If end, exit program

        jsr is_vampire     ; Jump to subroutine to check if number is a vampire
        bcc not_vampire    ; If not a vampire, skip to the next number

        lda number, x      ; If a vampire number, load the number again
        jsr print_number   ; Print the vampire number
        jsr print_nl       ; Print a new line

not_vampire
        inx                ; Increment index
        jmp check          ; Continue checking the next number

end     rts                ; End program

is_vampire
        ; Setup buffer for storing digits
        lda #$00
        sta $01

        ldx #0             ; Initialize index
        ldy #0             ; Initialize index

        lda number, x      ; Load the number
        beq end             ; If end of number, exit subroutine

        cmp #$0A           ; Check if number is less than 10
        bcc single_digit   ; If less than 10, then it's a single digit number

multi_digit
        sta $00, y         ; Store the current digit in buffer
        inx                ; Increment index
        ldy $01             ; Load the current index in buffer
        cmp number, x      ; Check if end of number
        bne multi_digit     ; If not end, continue storing digits

        lda $00, y         ; Load the last digit stored in buffer
        cmp #$0A           ; Check if digit greater than 10
        bcc end             ; If greater than 10, exit subroutine

        ldy #$00            ; Initialize index
        ldx #0             ; Initialize index

compare
        lda $00, y         ; Load the digit from buffer
        cmp number, x      ; Compare with current digit in the number
        bne not_vampire     ; If not equal, then not a vampire number

        iny                ; Increment index in buffer
        inx                ; Increment index in number
        lda number, x
        beq end             ; If end of number, it's a vampire number
        bne compare         ; Continue comparing digits

single_digit
        lda number, x      ; Load the single digit number
        cmp #$0A           ; Check if digit greater than 10
        bcc end             ; If less than 10, exit subroutine

        lda number, x      ; Load the single digit number
        rts                ; Return from subroutine

print_number
        ; Print the current number
        lda #$FF
        jsr $FFD2          ; Print in decimal
        rts

print_nl
        ; Print a new line
        lda #$0D
        jsr $FFD2          ; Print character
        lda #$0A
        jsr $FFD2          ; Print character
        rts

        .end
