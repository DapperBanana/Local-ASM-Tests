
        .org $2000

encrypt:
        ldx #$00        ; Initialize index register X to 0

loop:
        lda $2000,x     ; Load character into the accumulator
        beq done        ; Exit loop if end of string is reached

        cmp #$41        ; Check if character is uppercase letter
        bcc is_not_uppercase
        cmp #$5B
        bcs is_not_uppercase

        adc #$03        ; Add 3 to ASCII value for encryption
        cmp #$5B
        bcc store       ; If overflow, store result
        sbc #$1A        ; Otherwise subtract 26 to wrap around

store:
        sta $2000,x     ; Store result back in memory
        inx             ; Increment index
        jmp loop        ; Continue looping

is_not_uppercase:
        cmp #$61        ; Check if character is lowercase letter
        bcc continue
        cmp #$7B
        bcs continue

        adc #$03        ; Add 3 to ASCII value for encryption
        cmp #$7B
        bcc store       ; If overflow, store result
        sbc #$1A        ; Otherwise subtract 26 to wrap around
        jmp store

continue:
        jmp store

done:
        rts

        .org $3000

decrypt:
        ldx #$00

loop2:
        lda $2000,x
        beq end

        cmp #$41
        bcc is_not_uppercase2
        cmp #$44
        bcs is_not_uppercase2
        sbc #$03
        cmp #$40
        bcs store2
        adc #$1A
        jmp store2

is_not_uppercase2:
        cmp #$61
        bcc continue2
        cmp #$64
        bcs continue2
        sbc #$03
        cmp #$60
        bcs store2
        adc #$1A
        jmp store2

continue2:
        jmp store2

store2:
        sta $2000,x
        inx
        jmp loop2

end:
        rts

