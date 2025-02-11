
        .org $1000
        
start   lda #0              ; initialize accumulator to 0
        sta result
        
loop    lda data,x         ; load next roman numeral character
        beq done           ; check for end of string
        
        cmp #$49           ; check if character is 'I'
        beq add_one        ; if true, add 1 to accumulator
        
        cmp #$56           ; check if character is 'V'
        beq add_five       ; if true, add 5 to accumulator
        
        cmp #$4C           ; check if character is 'L'
        beq add_fifty      ; if true, add 50 to accumulator
        
        cmp #$44           ; check if character is 'D'
        beq add_five_hundred ; if true, add 500 to accumulator
        
        cmp #$4D           ; check if character is 'M'
        beq add_thousand   ; if true, add 1000 to accumulator
        
done    rts                 ; return with result in accumulator

add_one clc                 ; add 1 to accumulator
        lda result
        adc #1
        sta result
        jmp next
        
add_five
        clc                 ; add 5 to accumulator
        lda result
        adc #5
        sta result
        jmp next
        
add_fifty
        clc                 ; add 50 to accumulator
        lda result
        adc #50
        sta result
        jmp next
        
add_five_hundred
        clc                 ; add 500 to accumulator
        lda result
        adc #500
        sta result
        jmp next
        
add_thousand
        clc                 ; add 1000 to accumulator
        lda result
        adc #1000
        sta result
        jmp next
        
next    inx                 ; increment index to next character
        jmp loop            ; continue looping

result  .byte 0             ; accumulator for result

data    .byte 'M','C','M','X','C','I',0 ; sample input string ("MCMXCIX")
