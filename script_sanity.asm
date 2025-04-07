
.ORG $0200
START LDX #$00     ; Point to the start of the text
LOOP LDA TEXT,X    ; Load the next character from the text
    BEQ END        ; If we reach the end of the text, exit
    CMP #'A'       ; Check if the character is a letter
    BCC NEXT       ; If it is not, skip to the next character
    CMP #'Z'       ; Check if the character is in the range of 'A' to 'Z'
    BCS NEXT       ; If it is not, skip to the next character
    ADC #$03       ; Add 3 to the ASCII code of the character
    CMP #'Z'       ; Check if the character goes beyond 'Z'
    BCC NOOVERFLOW ; If it does not, continue
    SEC            ; If it goes beyond 'Z', enable carry
    SBC #$1A       ; Subtract 26 from the result to wrap around from 'A'
NOOVERFLOW STA ENCRYPTED,X ; Store the encrypted character
NEXT INX            ; Move to the next character
    JMP LOOP       ; Continue encrypting the text
END BRK            ; Exit the program

; Encrypted text
ENCRYPTED .BLKB 256

; Input text to be encrypted
TEXT .BYTE "HELLO, WORLD! THIS IS A TEST.", 0

.END
