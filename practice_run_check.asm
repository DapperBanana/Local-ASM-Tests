
ORG $600

START LDX #0             ; Initialize index to point at the first word
     LDY #0             ; Initialize index to point at the first character of the word
     LDA MESSAGE,X      ; Load the first character of the word into A register
     BEQ END            ; If end of string, exit the program
     STA CURRENT_CHAR   ; Save the current character
LOOP LDA MESSAGE,X      ; Load the next character of the word into A register
     BEQ PROCESS_WORD   ; If end of word, process the word
     CMP SPACE          ; Compare with space character
     BEQ SAVE_WORD      ; If space character, save the word
     INY                ; Increment index to point at the next character of the word
     INX                ; Increment index to point at the next character in the string
     JMP LOOP           ; Repeat loop

PROCESS_WORD LDA #0       ; Initialize count for the word
             STA COUNT,Y ; Save the count for the current word
             LDX #0      ; Reset index to point to the start of the string
             JMP START   ; Start counting the next word

SAVE_WORD   LDX #0        ; Reset index to point at the first word
            LDY #0        ; Reset index to point at the first character of the word
            LDA COUNT,Y   ; Load the count for the current word
            CLC           ; Clear carry flag for ADD operation
            ADC #1        ; Increment the count for the current word
            STA COUNT,Y   ; Save the updated count
            JMP START     ; Start counting the next word

END  BRK                ; Exit program

MESSAGE .ASC "HELLO WORLD HELLO ASSEMBLY WORLD"   ; Input string
SPACE   .BYTE $20        ; Space character

COUNT   .BLKB 10         ; Array to store the count for each word

CURRENT_CHAR .BYTE 0     ; Variable to store the current character

