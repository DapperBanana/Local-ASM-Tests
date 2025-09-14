
        .org $0200    ; Start program at address $0200

start:  lda number   ; Load the number to check into the accumulator
        jsr isPerfectSquare  ; Call the subroutine to check if the number is a perfect square
        beq perfectSquareFound  ; Branch if the number is a perfect square
        jmp notPerfectSquareFound  ; Jump if the number is not a perfect square

isPerfectSquare:
        ; Initialize variables
        lda #$00    ; Clear the accumulator
        sta remainder  ; Clear the remainder variable
        sta count  ; Clear the count variable
        
checkLoop:
        cmp count  ; Compare the count with the number
        beq perfectSquare  ; Branch if the count is equal to the number
        lda number  ; Load the number into the accumulator
        clc
        jsr divideBy2  ; Divide the number by 2
        cmp remainder  ; Compare the remainder
        beq isPerfectSquareDone  ; Branch if the remainder is zero
        inc count  ; Increment the count
        jmp checkLoop  ; Repeat the loop
        
divideBy2:
        lsr  ; Shift the accumulator right (divide by 2)
        sta number  ; Store the result back into the number variable
        rol  ; Rotate the remainder into the carry flag
        ror remainder  ; Rotate the remainder
        
        rts  ; Return from subroutine

perfectSquare:      
        lda #$01  ; Load 1 (true) into the accumulator
        rts  ; Return from subroutine

isPerfectSquareDone:
        lda #$00  ; Load 0 (false) into the accumulator
        rts  ; Return from subroutine

perfectSquareFound:
        lda #$01  ; Load 1 (true) into the accumulator
        rts  ; Return from subroutine

notPerfectSquareFound:
        lda #$00  ; Load 0 (false) into the accumulator
        rts  ; Return from subroutine

number: .byte $19    ; Number to check if it is a perfect square
remainder: .byte $00 ; Remainder for division
count: .byte $00     ; Counter variable

        .end
