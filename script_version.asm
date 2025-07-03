
        .text
        .org $0200

start:
        lda number    ; Load the number to be checked into the accumulator
        jsr isNarcissistic ; Call the function to check if the number is narcissistic

        beq is_narcissistic  ; Branch if the number is narcissistic
        lda #$00            ; Load 0 into the accumulator if the number is not narcissistic
        sta result          ; Store the result in memory
        jmp end             ; Jump to the end of the program

is_narcissistic:
        lda #$01            ; Load 1 into the accumulator if the number is narcissistic
        sta result          ; Store the result in memory
        jmp end             ; Jump to the end of the program

isNarcissistic:
        ldx #0              ; Initialize the sum to 0
        ldy number          ; Load the number to be checked into Y register
        lda #0              ; Initialize the digit counter to 0
loop:
        cmp #0              ; Check if the number is 0
        beq done            ; If the number is 0, exit the loop
        tax                 ; Save X register (sum) to Y register
        ldy number          ; Load the number to be checked into Y register
        lsr                 ; Shift the number right
        bcc skip            ; Skip if the carry flag is set
        inx                 ; Increment the sum by one
skip:
        dey                 ; Decrement the digit counter
        jmp loop            ; Loop back to the beginning
done:
        lda sum             ; Load the sum into the accumulator
        bne check_result    ; Branch if the sum is not equal to 1

result:
        .byte 0            ; Memory location to store the result

number:
        .byte 153          ; Number to be checked

sum:
        .byte 0           ; Variable to store the sum of the narcissistic number

end:
        rts               ; Return from subroutine
