
    .org $0600

string    .asciiz "hello world"
occurrences .res 256

    .org $0800
start:
    ldx #0              ; initialize index to zero
loop:
    lda string,x       ; load next character from string
    beq end            ; if end of string, exit loop
    sta $02            ; store current character in $02
    lda occurrences,x  ; load number of occurrences of current character
    clc
    adc #1             ; increment number of occurrences
    sta occurrences,x  ; store updated number of occurrences
    inx                ; move to next character
    jmp loop

end:
    rts
