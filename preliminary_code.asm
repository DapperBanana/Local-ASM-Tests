
START    LDX #0          ; Initialize index
         LDY #0          ; Initialize index for loop
READCHAR LDA MESSAGE,Y   ; Load character from input string
         CMP #32         ; Check if character is a space
         BEQ SKIP        ; Skip if space character
         CMP #97         ; Check if character is lowercase
         BMI CONV_UPPER  ; Branch if uppercase
         STA TEMP,X     ; Store character in temporary buffer
         JMP CONTINUE   ; Continue to read next character
CONV_UPPER CMP #122        ; Check if character is lowercase
         BMI CONTINUE  ; Branch if already uppercase
         SEC            ; Set carry flag
         SBC #$20       ; Convert lowercase to uppercase
         STA TEMP,X    ; Store character in temporary buffer
         JMP CONTINUE  ; Continue to read next character
SKIP     STA TEMP,X     ; Store space character as is
CONTINUE INY             ; Increment index for string
         INX             ; Increment index for temporary buffer
         CMP #0          ; Check for end of string
         BEQ END         ; Branch if end of string
         JMP READCHAR    ; Read next character
END      LDA #0          ; Null terminate temporary buffer
         STA TEMP,X
         LDX #0          ; Reset index for output string
         LDY #0          ; Initialize index for loop
WRITECHAR LDA TEMP,Y      ; Load character from temporary buffer
         STA OUTPUT,Y    ; Store character in output string
         INY             ; Increment index for temporary buffer
         INX             ; Increment index for output buffer
         CMP #0          ; Check for end of string
         BEQ FINISH      ; Branch if end of string
         JMP WRITECHAR   ; Write next character
FINISH   RTS             ; Return from subroutine

MESSAGE  .BYTE "hello, world", 0 ; Input string
TEMP     .BLKB 20        ; Temporary buffer for modification
OUTPUT   .BLKB 20        ; Output string
