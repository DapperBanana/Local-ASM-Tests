
; Load address of input string into the X register
    LDX #STRING
    
; Calculate the length of the string
COUNT:
    LDY #0
    LDAA 0,X
    CMPA #$00
    BEQ REVERSE
    INX
    INY
    BRA COUNT

; Reverse the string
REVERSE:
    LDY #0
    LDX #STRING
    SUBY #1
REVERSE_LOOP:
    LDAA 0,X
    LDAB 0,Y
    STAA 0,Y
    STAB 0,X
    INX
    DEY
    CPY #0
    BNE REVERSE_LOOP

; End of program
    RTS

; Data section
STRING:
    .ASCIZ "HELLO"
