
START LDX #$00    ; Initialize index to 0
      LDA STR1,X  ; Load character from first string
      CMP STR2,X  ; Compare character with second string
      BEQ NEXT    ; If characters are equal, go to next character
      INC HAMMING ; Increment Hamming distance
NEXT  INX          ; Increment index
      CPX #LENGTH ; Compare index with length of strings
      BCC START   ; If index is less than length, go to start

      ; Display Hamming distance in decimal format
      LDA HAMMING  ; Load Hamming distance
      JSR TOASCII  ; Convert to ASCII
      JSR PUTCHAR  ; Display ASCII character
      BRK          ; End program

; Initialize variables
STR1    .BYTE "STRING1",0
STR2    .BYTE "STRING2",0
LENGTH  .BYTE $07   ; Length of strings
HAMMING .BYTE $00   ; Hamming distance

; Subroutine to convert decimal value to ASCII character
TOASCII LDX #$00
        STA $80
        LDA #$02
LOOP    SBC #$01
        BCC NEXT
        STA $80,X
        INX
        JMP LOOP
NEXT
        RTS

; Subroutine to display ASCII character
PUTCHAR LDA $80
        JSR $FFD2
        RTS
