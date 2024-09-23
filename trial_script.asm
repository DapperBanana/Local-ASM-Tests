
.INCLUDE "vcs.h"

.MODEL SMALL

.STACK 100

.DATA
seed       .BYTE 0
rng        .BYTE 0
word1      .BYTE "The", 0
word2      .BYTE "quick", 0
word3      .BYTE "brown", 0
word4      .BYTE "fox", 0
word5      .BYTE "jumps", 0
word6      .BYTE "over", 0
word7      .BYTE "the", 0
word8      .BYTE "lazy", 0
word9      .BYTE "dog", 0
word_list  .BYTE word1, word2, word3, word4, word5, word6, word7, word8, word9
word_count .BYTE 9

.CODE
start
    LDA #42 ; Seed the random number generator
    STA seed
    JSR generate_sentence

generate_sentence
    LDA word_count
    CLC
    ADC seed
    STA rng

    LDX #0
pick_word
    LDA rng
    JSR rand_modulo
    STA rng
    TAX

    LDA word_list, X
    JSR print_string

    INX
    CPX word_count
    BNE pick_word

    RTS

rand_modulo
    AND #7F
    RTS

print_string
    LDX #0
print_loop
    LDA word_list, X
    BEQ end_print
    JSR CHROUT
    INX
    JMP print_loop
end_print
    RTS

.CHAROUT
    JSR $F001
    RTS

.END start
