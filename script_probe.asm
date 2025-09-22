
        .org $0600   ; Starting address
        
start   LDX #0      ; Initialize X register to 0
        LDY #0      ; Initialize Y register to 0
        LDA str     ; Load address of string into accumulator
        STA ptr     ; Store address of string in pointer
        
next    LDA (ptr),Y ; Load next character of string
        CMP #$00    ; Check for end of string
        BEQ done    ; If end of string, jump to done
        
        CMP #$20    ; Check for space character
        BEQ space   ; If space character, jump to space
        
        INY         ; Increment Y register to move to next character
        BNE next    ; Continue to next character
        
space   INX         ; Increment X register to count word occurrence
    
loop    INY         ; Skip space characters
        LDA (ptr),Y ; Load next character
        CMP #$20    ; Check for space character
        BEQ next    ; If space character, jump to next
        CMP #$00    ; Check for end of string
        BEQ done    ; If end of string, jump to done
        BNE loop    ; Otherwise, continue in loop
        
done    STX count  ; Store count of word occurrences
        BRK        ; Exit program
        
str     .asc "hello world hello program world"
ptr     .byte 0    ; Pointer to string
count   .byte 0    ; Count of word occurrences
        
        .end        ; End of program
