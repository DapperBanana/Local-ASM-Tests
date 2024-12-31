
        .org $0200

start:  lda number    ; Load the decimal number into the accumulator
        ldx #$00      ; Initialize the numerator to 0
        ldy #$01      ; Initialize the denominator to 1

loop:   cmp #$00      ; Check if the accumulator is 0
        beq done      ; If it is, exit the loop

        asl           ; Multiply the accumulator by 2 (equivalent to shifting left by one bit)
        bcc numerator ; If the carry flag is clear, the bit shifted out was 0
        inc x         ; If the carry flag is set, increment the numerator by 1

numerator: 
        cmp y         ; Check if the numerator is greater than or equal to the denominator
        bcc divide    ; If it is not, continue to the division step

        dec x         ; Decrement the numerator
        asl y         ; Shift the denominator left by 1
        bcs numerator ; Continue checking if the numerator is greater than or equal to the denominator

divide: 
        lda y         ; Load the denominator into the accumulator
        sec           ; Set the carry flag to perform division
        sbc x         ; Subtract the numerator from the denominator
        sta y         ; Store the result back in the denominator

        jmp loop      ; Continue looping

done:   ; The fraction is now stored in the numerator and denominator

        ; Add code here to handle the output or further processing

number: .byte $15    ; Decimal number to convert

        .end
