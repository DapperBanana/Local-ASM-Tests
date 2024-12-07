
        processor 6502
        org $1000

num     .byte $42       ; Change this to the number you want to check
length  .byte 0         ; Length of the number
temp    .byte 0         ; Temporary storage
result  .byte 0         ; Result of palindrome check

start   lda num         ; Load the number into accumulator
        jsr countDigits ; Count number of digits in the number
        ldx length      ; Load length into X register
        ldy #0          ; Initialize Y register
        ldx #0          ; Initialize X register
        
compare lda num, x    ; Load first digit from the front
        cmp num, y    ; Load first digit from the back (length - y)
        bne notPalindrome ; If the digits don't match, it's not a palindrome
        inx           ; Increment front position
        dey           ; Decrement back position
        cpx length    ; Check if all digits have been compared
        beq palindrome ; If so, it's a palindrome
        bne compare   ; Continue comparing digits

notPalindrome
        ldy #0        ; Not a palindrome, set result to 0
        sty result
        jmp end

palindrome
        ldy #1        ; Palindrome, set result to 1
        sty result

end     rts

countDigits
        ldy #0        ; Initialize Y register
loop    lda num, y    ; Load digit at position Y
        beq done      ; If digit is 0, end loop
        iny           ; Increment position
        bne loop      ; Continue counting digits
done    lda y         ; Store length in memory
        sta length
        rts

        end start
