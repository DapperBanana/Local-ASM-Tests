
        .text
        .globl _start

_start:
        lda #0        ;Initialize sum to 0
        ldx #10       ;Initialize divisor to 10
        ldy #0        ;Initialize counter to 0
        
loop:
        sta result    ;Store current sum in result
        lda number    ;Load number into A register
        clc           ;Clear carry flag
        adc #$30      ;Convert ASCII digit to its numeric value
        cmp #$3A      ;Check if A register contains value greater than '9'
        bcc add       ;If less than '9', proceed to add

convert_to_digit:
        sbc #$07      ;Adjust the numeric value to convert it back to digit
        sta number    ;Store the new digit in number
        jmp add

add:
        adc sum       ;Add the current digit to the sum
        sta sum       ;Store the new sum
        lda number    ;Load number into A register
        lsr           ;Shift the number 4 bits to right
        sta number    ;Store the new number
        bne loop      ;If number is not zero, repeat loop
        
done:
        iny           ;Increment the counter
        lda sum       ;Load the sum into A register
        cmp #$0A      ;Check if sum is a single digit
        bcc loop      ;If sum is not single digit, repeat loop
        
result:
        lda sum       ;Final result will be in sum register
        pla
        brk           ;End program

        .data
number:
        .byte 0x39    ;Initial number to find sum of its digits

result:
        .byte 0x00    ;Store the result of the sum
sum:
        .byte 0x00    ;Register to store the sum
