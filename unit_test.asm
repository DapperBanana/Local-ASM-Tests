
        .org $0200

start   LDX #$00        ; Initialize word count to 0
        LDY #$00
        
loop    LDA $4000,Y     ; Load next character from text file
        BEQ end         ; If character is 0 (end of file), exit loop
        CMP #$20        ; Compare character to space
        
        BEQ check_space ; Branch to check_space if character is a space
        
continue INC Y          ; Increment index to read next character
        JMP loop        ; Continue looping

check_space
        INX             ; Increment word count
        JMP loop        ; Continue looping

end     STX $4020       ; Store word count in memory location $4020
        BRK             ; End program
