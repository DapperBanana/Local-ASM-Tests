
        .org $0200       ; Start the program at address $0200

start   lda number      ; Load the initial number to accumulate the sum of its digits
        sta total       ; Store the initial number in the total variable
        ldx #0          ; Initialize the index register X to 0

loop    ldy #$00        ; Initialize the sum variable Y to 0

addLoop lda total       ; Load the accumulated total of digits
        bcc notCarry    ; If there is no carry, then go to notCarry
        adc #$30        ; Add 3 (ASCII code for '0') to convert to ASCII
        jsr print       ; Print the sum of the digits
        ldy #$00        ; Reset the sum variable Y
        jmp next        ; Jump to next

notCarry
        lda total       ; Load the accumulated total of digits 
        and #$0F        ; Mask the lower 4 bits to get the digit
        clc
        adc sum         ; Add the digit to the sum
        sta sum         ; Store the updated sum
        lsr             ; Shift the accumulated total to the right
        bpl addLoop     ; Loop until all digits are processed

next    lda sum         ; Load the sum of digits
        sta total       ; Store the sum as the new total
        lda sum         ; Load the sum of digits
        cmp #$0A        ; Compare it with 10
        bcc done        ; If the sum is less than 10, we are done
        jmp loop        ; Otherwise, repeat the process

done    lda sum         ; Load the final sum
        adc #$30        ; Add 3 (ASCII code for '0') to convert to ASCII
        jsr print       ; Print the final single-digit sum

doneLoop
        jmp doneLoop    ; Loop indefinitely

print   lda #$01        ; Print the character in COUT
        jsr $FFD2       ; Call the KERNAL routine
        rts             ; Return from subroutine

number  .byte $23        ; Initial number to calculate the sum of digits
total   .byte $00        ; Accumulated total of digits
sum     .byte $00        ; Sum of digits

        .end
