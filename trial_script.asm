
.org $0200

START:
    LDX #0  ; Initialize index register X
    LDY #0  ; Initialize index register Y

READ_LOOP:
    LDA $4000,X  ; Load a byte from memory into the accumulator 
    CMP #13      ; Compare the byte with carriage return
    BEQ PRINT   ; If the byte is a carriage return, jump to print
    JSR $FFD2    ; Print the byte
    INX          ; Increment X
    BNE READ_LOOP ; Branch back to READ_LOOP

PRINT:
    LDA #10      ; Load a line feed into the accumulator
    JSR $FFD2    ; Print the line feed
    INY          ; Increment Y
    LDA $4000,Y  ; Load a byte from memory into the accumulator
    BEQ END      ; If end of file, jump to END
    JMP READ_LOOP ; Jump back to READ_LOOP

END:
    RTS          ; Return from subroutine

    .org $4000
    .byte $48,$65,$6C,$6C,$6F,$2C,$57,$6F,$72,$6C,$64,$21,$0D
    .byte $48,$69,$20,$74,$68,$65,$72,$65,$21,$0D,$49,$20,$61
    .byte $6D,$20,$61,$20,$43,$53,$56,$20,$66,$69,$6C,$65,$21
    .byte $0D,$0D,$54,$68,$61,$6E,$6B,$20,$79,$6F,$75,$21,$0D
    .byte $0D,$47,$6F,$6F,$64,$62,$79,$65,$21,$0D

    .end
