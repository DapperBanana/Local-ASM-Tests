
LOOP:
    LDA STRING,X      ; Load character from beginning of string
    STA TEMP          ; Store character in temporary memory location

    LDA STRING,Y      ; Load character from end of string
    STA STRING,X      ; Store character at beginning of string
    
    LDA TEMP          ; Load character from temporary memory location
    STA STRING,Y      ; Store character at end of string
    
    INX               ; Increment index for beginning of string
    DEY               ; Decrement index for end of string
    
    CPX Y             ; Compare indices
    BCC LOOP          ; Repeat loop until X is less than Y

    RTS               ; Return from subroutine

TEMP: .BYTE $00        ; Temporary memory location
STRING: .BYTE "HELLO",0 ; String to be reversed
