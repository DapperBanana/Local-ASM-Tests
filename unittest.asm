
        .org $0200

ROMAN_NUMERAL  .asciiz "VIII"
RESULT          .byte 0

        .org $FC
ROMAN_TO_INT:
        LDX #0         
LOOP:   
        LDA ROMAN_NUMERAL, X   
        BEQ DONE
        
        CMP #'M'
        BEQ ADD_1000
        CMP #'D'
        BEQ ADD_500
        CMP #'C'
        BEQ ADD_100
        CMP #'L'
        BEQ ADD_50
        CMP #'X'
        BEQ ADD_10
        CMP #'V'
        BEQ ADD_5
        CMP #'I'
        BNE INVALID_INPUT
        
        INC X
        LDA ROMAN_NUMERAL, X
        CMP #'I'
        BNE INVALID_INPUT
        
        ADD_1:
        CLC
        ADC #1
        JMP INC_X
        
        ADD_5:
        CLC
        ADC #5
        JMP INC_X
        
        ADD_10:
        CMP #5
        BEQ SUB_1
        CLC
        ADC #10
        JMP INC_X
        
        ADD_50:
        CLC
        ADC #50
        JMP INC_X
        
        ADD_100:
        CMP #500
        BEQ SUB_100
        CLC
        ADC #100
        JMP INC_X
        
        ADD_500:
        CLC
        ADC #500
        JMP INC_X
        
        ADD_1000:
        CLC
        ADC #1000
        JMP INC_X
        
        SUB_1:
        CLC
        ADC #4
        JMP INC_X
        
        SUB_100:
        CLC
        ADC #400
        JMP INC_X
        
        INC_X:
        INC X
        BNE LOOP
        
DONE:
        STA RESULT
        RTS

INVALID_INPUT:
        LDA #255
        STA RESULT
        RTS
