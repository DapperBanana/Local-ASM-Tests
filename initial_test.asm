
; Program to check if a given string is a valid IPv4 address
; Input: String stored at memory location $200
; Output: ASCII character 'Y' if valid, 'N' if invalid

        .org $1000

start   LDX #$00            ; Initialize index to 0
        LDA $200, X         ; Load the first character of the string
check   BEQ valid          ; Branch if end of string reached
        CMP #'0'            ; Check if it is a numeric character
        BCC invalid         ; Branch if not a numeric character
        CMP #'9'
        BCS invalid

        INX                 ; Increment index
        LDA $200, X         ; Load the next character
        CMP #'.'            ; Check if it is a period
        BEQ period          ; Branch if it is a period

        CMP #'0'            ; Check if it is a numeric character
        BCC invalid         ; Branch if not a numeric character
        CMP #'9'
        BCS invalid

        JMP check           ; Continue checking characters

period  INX                 ; Increment index
        LDA $200, X         ; Load the next character

        CMP #'0'            ; Check if it is a numeric character
        BCC invalid         ; Branch if not a numeric character
        CMP #'9'
        BCS invalid

        INX                 ; Increment index
        LDA $200, X         ; Load the next character

        CMP #'0'            ; Check if it is a numeric character
        BCC invalid         ; Branch if not a numeric character
        CMP #'9'
        BCS invalid

        INX                 ; Increment index
        LDA $200, X         ; Load the next character

        CMP #'0'            ; Check if it is a numeric character
        BCC invalid         ; Branch if not a numeric character
        CMP #'9'
        BCS invalid

        JMP check           ; Continue checking characters

valid   LDA #'Y'            ; Load ASCII character 'Y'
        STA $201            ; Store it at memory location $201

end     BRK                 ; Halt the program

invalid LDA #'N'            ; Load ASCII character 'N'
        STA $201            ; Store it at memory location $201
        JMP end             ; End the program

        .org $200
        .byte "255.255.255.255", 0    ; Input string

        .org $201
        .byte 0                        ; Output character

        .end

