
ORG $0200
START:
    LDX #0
    LDY #0

LOOP_X:
    LDA STR1,X
    BEQ DONE
    
    LOOP_Y:
        LDA STR2,Y
        BEQ NEXT_X
        
        CMP STR1,X
        BEQ FOUND_COMMON
        
        INY
        JMP LOOP_Y
        
    FOUND_COMMON:
        STA RESULT,Y
        INY
        JMP NEXT_Y
        
    NEXT_Y:
        INY
        JMP LOOP_Y
        
    NEXT_X:
        INX
        JMP LOOP_X

DONE:
    BRK

STR1: .BYTE "STRING1"
STR2: .BYTE "STRING2"
RESULT: .BYTE 0

.END
