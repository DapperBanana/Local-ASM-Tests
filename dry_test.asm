
START    LDX #0         ; Initialize X register to 0
         LDA NUM+2,X   ; Load the most significant byte of the number
         STA ACC+2,X   ; Save it in the accumulator
         LDA NUM+1,X   ; Load the next most significant byte of the number
         STA ACC+1,X   ; Save it in the accumulator
         LDA NUM,X     ; Load the least significant byte of the number
         STA ACC,X     ; Save it in the accumulator

MAIN     JSR SQR        ; Call the square root subroutine
         STA RESULT+2,X ; Save the most significant byte of the result
         LDA RESULT+1,X ; Load the next most significant byte of the result
         STA RESULT+1,X ; Save it in the result
         LDA RESULT,X   ; Load the least significant byte of the result
         STA RESULT,X   ; Save it in the result

END      BRK            ; End of the program

SQR      LDX #0         ; Initialize X register to 0
         LDA $0000,X    ; Load the least significant byte of the number
         STA NUM2       ; Save it in NUM2
         LDA $0001,X    ; Load the next most significant byte of the number
         STA NUM2+1     ; Save it in NUM2+1
         LDA $0002,X    ; Load the most significant byte of the number
         STA NUM2+2     ; Save it in NUM2+2

         LDA #16        ; Initialize C to 16
         STA C

LOOP     LDA #0         ; Initialize A to 0
         STA B

LOOP2    ASL NUM2      ; Shift the most significant byte of the number left
         ROL NUM2+1    ; Rotate the next most significant byte of the number left
         ROL NUM2+2    ; Rotate the least significant byte of the number left
         ROL B         ; Rotate B left
         CLC
         ADC C         ; Add C
         STA TMP
         LDA B         ; Load B
         ADC C         ; Add C
         STA TMP+1
         CMP ACC+2    ; Compare the accumulated sum with the number
         BCS DONE      ; If the accumulated sum is greater than or equal to the number, exit the loop
         INC B         ; Otherwise, increment B
         JMP LOOP2     ; Repeat the process
         
DONE     DEC B         ; Decrement B
         STA RESULT    ; Save B as the square root of the number
         RTS            ; Return from subroutine

NUM      .byte $19      ; Number to find the square root of (in little-endian format)
         .byte $85
         .byte $EB

ACC      .byte $00      ; Accumulator for the original number
         .byte $00
         .byte $00

RESULT   .byte $00      ; Result of the square root calculation
         .byte $00
         .byte $00

NUM2     .byte $00      ; Temporary storage for shifting the number
         .byte $00
         .byte $00

TMP      .byte $00      ; Temporary storage for the accumulated sum
         .byte $00
