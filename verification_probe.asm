
        .org $0200      ; Start address of program

prompt  .asciiz "Enter a number: $"
result  .asciiz "The sum is: $"
buffer  .ds 1         ; Buffer to store user input

        .org $FFFC      ; Reset vector
        .word start      ; Set reset vector to start of program

start   lda #<prompt
        ldx #0
        jsr $FFD2       ; Print string

        ldy #0          ; Initialize sum to 0
        lda #0

get_num lda #$00       ; Read input number from user
        jsr $FFCF       ; Input character
        cmp #13         ; Check for Enter key
        beq calculate  ; If Enter key pressed, start calculation

        sta buffer
        iny
        jmp get_num

calculate
        ldx #0
loop    lda buffer, x   ; Convert ASCII to integer
        cmp #$30
        bcc invalid_input
        cmp #$39
        bcs invalid_input
        sec
        sbc #$30
        clc
        adc result, y
        sta result, y
        inx
        iny
        cpx #1
        bne loop

print_result
        lda #<result
        ldx #0
        jsr $FFD2       ; Print string

        lda result, y   ; Print the sum
        jsr $FFD6       ; Print number as ASCII

        rts             ; End of program

invalid_input
        lda #"Invalid input. Only digits allowed.$"
        jsr $FFD2       ; Print error message
        jmp get_num     ; Get input again
