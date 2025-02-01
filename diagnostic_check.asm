
.data
data:
    .byte 3, 5, 7, 2, 4   ; Sample data dictionary

.text
start:
    ; Initialize variables
    lda #0              ; Load accumulator with 0
    sta $fb            ; Store it at memory location $fb for index
    lda #10           ; Load accumulator with 10 (bar width)
    sta $fc            ; Store it at memory location $fc

loop:
    ; Load data value from dictionary
    ldx $fb           ; Load X register with index
    lda data,x       ; Load accumulator with data value from dictionary
    tax                ; Transfer accumulator to X register

    ; Print bar chart
    lda $fc          ; Load accumulator with bar width
    jsr print_space   ; Print space before bar
    lda #35          ; Load accumulator with ASCII #
    jsr print_char    ; Print bar character

    ; Print data value
    jsr print_newline ; Print new line
    jsr print_space   ; Print space before data value
    jsr print_value   ; Print data value

    ; Increment index
    lda $fb         ; Load accumulator with index
    clc              ; Clear carry flag
    adc #1          ; Increment by 1
    sta $fb        ; Store incremented value back at index

    ; Check loop condition
    cmp #5          ; Compare with number of data points (5 in this case)
    bne loop        ; Branch to loop if not equal

    ; End of program
    brk

print_char:
    jsr $ffd2     ; Output character routine
    rts

print_space:
    lda #' '       ; Load accumulator with ASCII space character
    jsr print_char  ; Print space character
    rts

print_newline:
    lda #13       ; Load accumulator with ASCII carriage return character
    jsr print_char  ; Print carriage return
    lda #10       ; Load accumulator with ASCII line feed character
    jsr print_char  ; Print line feed
    rts

print_value:
    lda #$30     ; Load accumulator with ASCII offset for numbers
    clc          ; Clear carry flag
    adc data,x  ; Add data value to accumulator
    jsr print_char ; Print character
    rts
