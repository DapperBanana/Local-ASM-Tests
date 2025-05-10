
    .org $0200      ; Start address of the program

radius: .byte 5     ; Radius of the cylinder
height: .byte 10    ; Height of the cylinder
result: .word 0     ; Variable to store the result

    lda radius      ; Load radius into accumulator
    sta $fb         ; Store radius in memory at $fb
    lda height      ; Load height into accumulator
    sta $fc         ; Store height in memory at $fc

    lda $fb         ; Load radius from memory
    jsr square      ; Call subroutine to calculate square of radius
    sta $fe         ; Store square of radius at $fe

    lda $fb         ; Load radius from memory
    jsr multiply    ; Call subroutine to multiply radius by height
    lda $fe         ; Load square of radius from memory
    jsr multiply    ; Call subroutine to multiply square of radius by height

    lda $fe         ; Load result from memory
    sta result      ; Store result in memory

    lda result      ; Load result into accumulator
    jsr print       ; Call subroutine to print result

    rts             ; Return from subroutine

square:
    asl             ; Multiply by 2 (radius * radius)
    rts

multiply:
    sec             ; Set carry flag
    lda $fc         ; Load height from memory
    ror             ; Divide by 2
    adc $fe         ; Add radius*height to accumulator
    sta $fe         ; Store result in memory
    rts

print:
    ldx #2          ; Index for loop
print_loop:
    jsr divide     ; Print the result
    jsr add         ; Add ASCII offset to convert to printable character
    sta $fd,X      ; Store result in memory
    dex             ; Decrement loop index
    bpl print_loop  ; Loop until all digits printed
    ldx #2
    lda #46          ; ASCII value for decimal point '.'
    sta $fd,X
    jsr add         ; Add ASCII offset
    sta $fd,X
    lda #10          ; ASCII value for newline character
    jsr add         ; Add ASCII offset
    sta $fd,X
    jsr $ffd2       ; Print result
    rts

divide:
    ldx #$00        ; Initializes the quotient
    ldy #$00        ; Initializes the remainder
    lda result

divide_loop:
    cmp #10         ; Compare value to 10
    bcc done        ; If accumulator is less than 10, we're done
    sbc #10         ; Subtract 10 from accumulator
    inx             ; Increment quotient
    bpl divide_loop ; Repeat until accumulator is less than 10

done:
    sta result      ; Store the remaining value in memory
    lda #$30        ; Convert to ASCII
    clc             ; Clear carry flag
    adc #$30        ; Add offset for ASCII character '0'
    rts

add:
    clc             ; Clear carry flag
    adc #$30        ; Add ASCII offset for printable character
    rts
