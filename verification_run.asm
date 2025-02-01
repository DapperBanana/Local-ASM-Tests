
        .org $0200

start   LDX #$00
        LDY #$00
        LDA #NUM
loop    CMP #1
        BEQ result

        DEX
        CPX #2
        BNE check_7

        CPX #7
        BNE check_127

        CPX #127
        BEQ result

check_7 CPX #7
        BNE check_127

        BEQ result

check_127
        CPX #127
        BNE divide_by_two

        BEQ result

divide_by_two
        LDA #2
        JSR divide

        JMP loop

result  ; The given number is a Lucas-Carmichael number
        JMP $

divide  ; Divide the A register with X and store the result in A
        STA TEMP
        LDA TEMP
        SEC
        SBC X
        CMP #0
        BMI done
        INC TEMP
        JMP divide

done    RTS

NUM     .byte $FF  ; The input number 

TEMP    .byte $00  ; Temporary storage for division

        .end
