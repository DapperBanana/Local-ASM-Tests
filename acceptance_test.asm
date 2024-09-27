
START:
    LDX #0         ; Initialize index register
    LDA #10        ; Set password length to 10 characters
    STA LENGTH

GENERATE_PASSWORD:
    INX             ; Increment index
    LDA RAND        ; Load random number
    AND #$3F        ; Mask upper two bits to limit range (0-63)
    CMP #$20        ; Check if character is printable
    BCC GENERATE_PASSWORD  

    STA PASSWORD,X   ; Store character in password array

    DEX             ; Decrease password length
    BNE GENERATE_PASSWORD

PRINT_PASSWORD:
    LDX #0          ; reset index
LOOP:
    LDA PASSWORD,X  ; Load character
    JSR $FFD2       ; Call KERNAL routine to print character
    INX             ; Increment index
    CPX LENGTH     ; Compare with password length
    BCC LOOP        ; If less than password length, continue printing

    BRK             ; Exit program

RAND:
    .byte $00       ; Placeholder for random number

PASSWORD:
    .byte 0         ; Array to store password
    .ds 10          ; 10 bytes reserved for password
LENGTH:
    .byte 0         ; Variable to store password length

    .org $C000      ; Program entry point
    JMP START       ; Jump to start of program
