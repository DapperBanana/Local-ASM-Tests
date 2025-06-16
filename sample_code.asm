
; Program to count the number of occurrences of each character in a string

; Input: Address of the string in memory (pointer in zero page)
; Output: Counts of each character stored in memory starting at 0x0300

        .org $0200      ; Start of program
start:
        LDX #0          ; Initialize index
        STX COUNT       ; Clear count memory location
loop:
        LDA (STRING),X  ; Load character from string
        BEQ end         ; Exit loop if end of string
        JSR increment   ; Increment count for character
        
        INX             ; Move to next character
        BNE loop        ; Loop until end of string is reached
        
end:
        RTS             ; Return from subroutine
        
increment:
        STA CHAR        ; Store character to check
        LDX #0          ; Initialize index for counting
check:
        LDA CHAR        ; Load character to check
        CMP (COUNT),X   ; Check if character matches current count
        BEQ found       ; Continue if match found
        INX             ; Move to next count
        BEQ notFound    ; Jump if end of count memory reached
        BNE check       ; Continue checking
        
found:
        INC (COUNT),X   ; Increment count for character
        RTS             ; Return from subroutine
        
notFound:
        STA (COUNT),X   ; Store new character in count memory
        INC (COUNT),X   ; Increment count for new character
        RTS             ; Return from subroutine

        .org $0300      ; Start of count memory
COUNT:  .ds 256         ; Reserve space for character counts
        
        .org $0400      ; Start of character string
STRING:                    ; Input string (replace with desired string)
        .byte "hello, world!", 0

        .end
