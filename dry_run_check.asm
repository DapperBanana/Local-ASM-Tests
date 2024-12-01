
        .org $0200

start   lda #0           ; clear accumulator
        sta result      
        lda #1           ; set initial value for result
        sta prev_value  ; keeps track of previous value
        lda #7           ; set the length of the input Roman numeral string
        sta length

loop    ldx #0           ; set index for Roman numeral string
        lda numeral,x    ; load current character
        beq end          ; if end of string, exit loop
        cmp prev_value   ; compare current value with previous one
        bcc continue     ; if current value is greater than the previous one, add it
        lda prev_value   ; otherwise, subtract the previous value
        sbc value,x
        jmp increment

continue lda value,x     ; add current value
increment clc
        adc result       ; add current value to result
        sta result
        lda value,x      ; store current value in prev_value
        sta prev_value
        inx
        cpx length       ; check if reached end of string
        bne loop

end     rts

numeral .byte "CCXX",0    ; input Roman numeral (example: CCXX = 220)
value   .byte $64,$64,$L,$X,$X,$I,$I,0  ; corresponding decimal values for Roman numerals
result  .byte 0
prev_value .byte 0
length  .byte 0

        .end
