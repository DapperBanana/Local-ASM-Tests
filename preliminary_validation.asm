
; Fibonacci sequence using memoization in 6502 assembly
; Inputs:
; X - the index of the Fibonacci number to calculate (0-based)
; Y - the address of the lookup table to store memoized values
; Outputs:
; A - the nth Fibonacci number

Fibonacci:
    LDX #0         ; Initialize X to 0
    LDA $02        ; Load the index X from memory
    CMP #2         ; Compare with 2
    BCS .next      ; Branch if greater or equal to 2
    RTS            ; Return early for Fibonacci(0) = 0 and Fibonacci(1) = 1

.next:
    STA $00        ; Store the index X in memory
    LDA #$00       ; Load the low byte of the lookup table address
    STA $01        ; Store it in memory
    LDA $03        ; Load the high byte of the lookup table address
    STA $01+1      ; Store it in memory

.loop:
    LDA $00        ; Load the index X from memory
    CMP #$01       ; Compare with 1
    BEQ .calc      ; Branch if equal to 1
    CMP #$00       ; Compare with 0
    BCC .recurse   ; Branch if smaller than 0

.calc:
    LDA $00        ; Read the index X from memory
    SEC            ; Set the carry flag for subtraction
    SBC #1         ; Subtract 1 from X
    STA $04        ; Store the new index in memory
    LDA $01        ; Load the low byte of the lookup table address
    CLC            ; Clear the carry flag for addition
    ADC $04        ; Add the new index to the lookup table address
    STA $05        ; Store the low byte of the new lookup table address
    LDA $01+1      ; Load the high byte of the lookup table address
    ADC #$00       ; Add the carry to the high byte
    STA $05+1      ; Store the high byte of the new lookup table address

    LDA ($05),Y    ; Load the first term of the Fibonacci sequence from memory
    STA $06        ; Store it in memory
    INY            ; Increment the offset to get the second term
    LDA ($05),Y    ; Load the second term of the Fibonacci sequence from memory
    CLC            ; Clear the carry flag for addition
    ADC $06        ; Add the first and second terms
    STA $07        ; Store the result in memory
    INY            ; Increment the offset to get the next empty slot in the lookup table
    LDA $07        ; Load the result
    STA ($05),Y    ; Store the result in the lookup table

    JMP .done      ; Jump to the end of the function

.recurse:
    LDA #$00       ; Default value for Fibonacci(0) = 0
    LDY #$00       ; Load the offset 0 in Y register
    STA $07        ; Store the default value in memory

.done:
    JMP $34        ; Return to the caller

; Memory layout:
; $00 - Index X
; $01 - Address of the lookup table
; $02 - Input: Index of the Fibonacci number
; $03 - Input: Address of the lookup table
; $04 - Temporary index storage
; $05 - Temporary address storage
; $06 - Temporary storage for the first term
; $07 - Temporary storage for the second term or result
