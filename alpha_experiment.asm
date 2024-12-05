
        processor 6502
        org $0200
        
number  .byte $1A        ; The number to check if it is Harshad
        
start   lda number       ; Load the number into the accumulator
        cmp #$00          ; Check if the number is equal to 0
        beq not_harshad   ; If the number is 0, it is not a Harshad number
        
        ldx #$00          ; Initialize sum variable to 0
        
loop    clc               ; Clear carry flag
        lda number       ; Load the number into the accumulator
        and #$0F          ; Mask the lower 4 bits
        tax              ; Store the masked value in X register
        
        adc x             ; Add the masked value to the accumulator
        bcc skip          ; If no carry, skip the increment step
        
        inx              ; Increment sum if there is a carry
        
skip    lsr              ; Shift the number right by one bit
        bne loop         ; If the number is not 0, continue looping
        
        cmp number       ; Check if the sum is divisible by the original number
        beq is_harshad   ; If the sum is divisible, it is a Harshad number
        
not_harshad
        lda #$00          ; Set accumulator to 0 (not Harshad number)
        sta $0201         ; Store the result at memory location $0201
        rts
        
is_harshad
        lda #$01          ; Set accumulator to 1 (Harshad number)
        sta $0201         ; Store the result at memory location $0201
        rts
