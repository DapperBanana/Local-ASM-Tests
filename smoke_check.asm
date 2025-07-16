
    .text
    .globl _start
    
_start:
    ; Ask for user input
    lda #0
    jsr $ffd2 ; OUTPUT
    lda #": Enter a number: "
    jsr $ffd2 ; OUTPUT
    
    ; Read user input
    lda #0
    jsr $ffd0 ; INPUT
    sta number
    
    ; Call factorial function
    lda number
    jsr factorial
    
    ; Print result
    lda #0
    jsr $ffd2 ; OUTPUT
    lda #": Factorial = "
    jsr $ffd2 ; OUTPUT
    lda result
    jsr numberPrint
    
    ; Exit program
    lda #0
    jsr $ffcf ; EXIT
    
factorial:
    ; Initialize result to 1
    lda #1
    sta result

    ; Check if number is 0 or 1
    cmp #0
    beq endFactorial
    cmp #1
    beq endFactorial
    
    ; Decrement number
    dec
    
    ; Call factorial recursively
    jsr factorial
    
    ; Multiply result by number
    lda result
    cmp #0
    beq endFactorial
    lda number
    clc
    adc result
    sta result
    
endFactorial:
    rts

numberPrint:
    ; Calculate ASCII value of number
    ldx #3
loop:
    lsr
    lsr
    lsr
    lsr
    bcc skip
    adc #'0'
    jsr $ffd2 ; OUTPUT
skip:
    dex
    bne loop
    
    rts
    
    .data
    number: .byte 0
    result: .byte 0
