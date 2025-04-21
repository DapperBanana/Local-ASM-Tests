
; 6502 Assembly program to check if a given string is an isogram

        .org $0200      ; Start program at memory address $0200

        LDX #0         ; Initialize index to zero
loop    LDA str,X      ; Load character at index X from string
        BEQ is_isogram ; If end of string is reached, it's an isogram
check   CMP str,X      ; Compare character at index X with current character
        BEQ not_isogram; If characters are equal, it's not an isogram
        INX            ; Increment index
        CMP #$00       ; Check if end of string is reached
        BEQ is_isogram ; If end of string is reached, it's an isogram
        JMP loop       ; Continue looping
is_isogram
        LDA #$01       ; Load 1 to indicate isogram
        STA result     ; Store result
        BRK            ; End program

not_isogram
        LDA #$00       ; Load 0 to indicate not isogram
        STA result     ; Store result
        BRK            ; End program

        .org $0300      ; Data section
str     .byte "hello",0 ; String to check for isogram
result  .byte 0         ; Result of isogram check

        .end           ; End of program
