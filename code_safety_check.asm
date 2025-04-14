
.ORG $0200    ; Start address of program

Start    LDX #0      ; Initialize index variables
         LDY #0

         LDA List,X  ; Load first number from list
         STA Current  ; Store as current number
         INX           ; Increment index

Check    LDA List,X  ; Load next number from list
         CLC
         CMP Current  ; Compare with current number
         BEQ Same     ; If same, continue checking consecutive numbers
         BCC NewSeq   ; If greater, start new sequence
         
Increase INC Count   ; Increment count of consecutive numbers
         INX           ; Increment index
         JMP Check     ; Continue checking numbers

Same     INX           ; Increment index
         JMP Check     ; Continue checking numbers

NewSeq   LDA Count    ; Load count of consecutive numbers
         CMP MaxCount ; Compare with current max count
         BCC NotMax    ; If less, go to next iteration
         
         STA MaxCount ; Update max count
         LDX Y        ; Update index of start of longest sequence
         
NotMax   LDA #0      ; Reset count of consecutive numbers
         INY          ; Update index of start of new sequence
         JMP Check    ; Continue checking numbers

Exit     LDA MaxCount ; Load max count
         STA Result   ; Store in Result variable

         BRK          ; End of program

Result   .BYTE 0
Count    .BYTE 0
MaxCount .BYTE 0
Current  .BYTE 0
List     .BYTE $0F, $11, $17, $18, $19, $15, $1A, $1B, $1C, $1D

         .END
