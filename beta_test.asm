
        ; Factorial program in 6502 Assembly
        ; Calculate the factorial of a given number
        
        .org $0200

start   lda #0          ; Initialize accumulator to 0
        sta result      ; Initialize result to 0
        
        jsr getNumber   ; Call subroutine to get input number
        sta number      ; Store input number
        
        ldx number      ; Load input number into X register
        dex             ; Decrement X register to handle 0! case
        bne calcFact    ; Branch if input number is not 0
        
        inc result      ; Increment result to 1 (0! = 1)
        jmp displayResult  ; Jump to display result

calcFact
        lda #1          ; Initialize accumulator to 1
        
loop    mul number      ; Multiply accumulator by input number
        dey             ; Decrement Y register (for loop control)
        bne loop        ; Branch back to loop if Y register is not 0
        
        sta result      ; Store result
        
displayResult
        jsr clearScreen    ; Call subroutine to clear screen
        
        lda #0          ; Load accumulator with 0
        ldx result      ; Load X register with result
        jsr displayHex  ; Call subroutine to display result in hexadecimal
        
        rts             ; Return
        
getNumber
        ldy #0          ; Initialize Y register to 0
        
inputLoop
        jsr clearScreen    ; Call subroutine to clear screen
        
        lda #16         ; Load accumulator with 16 (for input limit)
        jsr getInput    ; Call subroutine to get input
        
        cmp #10         ; Compare input to ASCII value of 10 (newline)
        beq doneInput   ; Branch if input is newline
        
        lda (input),y  ; Load input number
        beq doneInput   ; Branch if end of input
        
        dex             ; Decrement X register
        bne inputLoop   ; Loop until all input digits are read
        
doneInput
        rts             ; Return
        
result  .byte 0         ; Variable to store result
number  .byte 0         ; Variable to store input number

        .include "subroutines.asm"  ; Include file with subroutines
