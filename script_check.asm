
        .org $0200   ; Start program at address $0200

start:
        LDX #0       ; Initialize index for scanning sentence
        LDY #0       ; Initialize index for storing reversed sentence
        LDY #$FF     ; Initialize index for end of stack
        
scan_loop:
        LDA sentence,X  ; Load character from sentence
        BEQ reverse ; If end of sentence, start reversing words
        
        CMP #$20   ; Check for space character
        BEQ reverse_word  ; If space, reverse word
        
        STA stack,Y      ; Store character in stack
        INY              ; Increment stack index
        
increment:
        INX              ; Increment index for scanning sentence
        JMP scan_loop

reverse_word:
        DEY              ; Decrement stack index
        LDA stack,Y      ; Load character from stack
        STA reversed_sentence,Y  ; Store character in reversed sentence
        CPY #$FF         ; Check for end of stack
        BNE reverse_word  ; If not end of stack, continue reversing word
        LDA #$20         ; Add space after word in reversed sentence
        STA reversed_sentence,Y
        INY              ; Move index to next location
        
reverse:
        DEY              ; Decrement stack index to remove extra space
        LDA reversed_sentence,Y  ; Load character from reversed sentence
        STA reversed_sentence,Y  ; Store character back to stack
        CPY #$FF         ; Check if reached end of reversed sentence
        BNE reverse       ; If not, continue reversing
        
        ; End of program
        BRK

; Data section
sentence:
        .null-terminated "Hello World! This is a sample sentence."

stack:
        .ds $100   ; Stack for storing characters
reversed_sentence:
        .ds $100   ; Reversed sentence after reversing words

        .end start   ; End program execution
