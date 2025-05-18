
START    LDA #$00      ; Initialize the accumulator to 0
         STA RESULT

         LDX #$08      ; Start from the least significant bit

CONVERT  LSR            ; Shift the number right to get the current bit
         BCC SKIP      ; If bit is 0, skip adding to result

         CLC           ; Clear carry flag
         LDA RESULT    ; Load the current result
         ADC #$01      ; Add 1 to the result
         STA RESULT    ; Store the new result

SKIP     DEX            ; Move to the next bit
         BNE CONVERT   ; Repeat for all bits

         ; End of conversion, RESULT now stores the decimal value

         ; Add code here to display the result or store it in memory

END      BRK            ; End the program

RESULT   .BYTE $00      ; Storage for the decimal result
