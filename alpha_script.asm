
START    LDX #2            ; Initialize X register to 2 (starting factor)
         LDA #NUMBER       ; Load the number to be factored into the accumulator
         STA ORIGINAL_NUM  ; Store the original number
         JSR FIND_FACTORS  ; Jump to subroutine to find prime factors
         BRK               ; Exit program

FIND_FACTORS
         LDA ORIGINAL_NUM  ; Load the original number
         CMP #1            ; Compare with the number 1
         BEQ END           ; If equal, exit subroutine
         
DIVIDE   CPX ORIGINAL_NUM  ; Compare X with the original number
         BEQ NEXT_FACTOR   ; If equal, move to the next factor
         LDA ORIGINAL_NUM  ; Load original number
         SEC
         SBC ORIGINAL_NUM  ; Subtract X from the original number
         BCC END_DIVIDE     ; If result is negative, exit division loop
         CLC
         ADC X             ; Increment X
         JMP DIVIDE        ; Continue division loop

NEXT_FACTOR
         INC X             ; Move to the next factor
         JMP FIND_FACTORS  ; Repeat process for the next factor

END_DIVIDE
         LDA ORIGINAL_NUM  ; Load original number
         SEC
         SBC X             ; Subtract X from the original number
         BNE FIND_FACTORS  ; If not zero, continue finding factors
         STA PRIME_FACTOR  ; Store prime factor in memory
         JSR PRINT_FACTOR  ; Jump to subroutine to print prime factor
         LDA PRIME_FACTOR  ; Load prime factor
         SEC
         SBC ORIGINAL_NUM  ; Subtract prime factor from the original number
         STA ORIGINAL_NUM  ; Update the original number
         JMP FIND_FACTORS  ; Repeat process for the new number

END      RTS               ; Return from subroutine

PRINT_FACTOR
         ; Code to print the prime factor to the screen

ORIGINAL_NUM .BYTE 0
PRIME_FACTOR .BYTE 0
NUMBER       .BYTE 48   ; The number to be factored

         .ORG $FFFC
         .WORD START
