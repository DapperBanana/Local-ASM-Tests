
        lda #0          ; Initialize sum to 0
        sta sum

start   lda number     ; Load the input number
        cmp #0          ; Check if number is 0
        beq done        ; If number is 0, exit
        
        adc sum         ; Add current digit to sum
        sta sum         ; Store updated sum
        lsr             ; Shift number right to get next digit
        jmp start       ; Repeat process for next digit

done    ; Sum of digits stored in memory location "sum"
        hlt             ; Halt program

number  .byte 123      ; Input number
sum     .byte 0        ; Variable to store sum of digits
