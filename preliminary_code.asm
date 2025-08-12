
; Load data into memory
LDA #0             ; Initialize accumulator
STA $2000          ; Set memory address for data
LDA #5             ; Set number of data points
STA $2001          ; Store in memory
LDA #10            ; Data point 1 value
STA $2002          ; Store in memory
LDA #20            ; Data point 2 value
STA $2003          ; Store in memory
LDA #30            ; Data point 3 value
STA $2004          ; Store in memory
LDA #15            ; Data point 4 value
STA $2005          ; Store in memory
LDA #25            ; Data point 5 value
STA $2006          ; Store in memory

; Display line chart
LDA #$20           ; Load accumulator with space character
LDX #0             ; Initialize X register
LDY $2001          ; Load Y register with number of data points

loop:
   LDA $2002, X    ; Load accumulator with data point value
   STA $0400, X    ; Store data point value in memory at $0400
   LDA $2002, X+1  ; Load accumulator with next data point value
   STA $0400, X+1  ; Store in memory at $0400
   LDA #$FF
   STA $0500, X
   STA $0500, X+1
   JSR draw_line   ; Call subroutine to draw line

   INX             ; Increment X register
   INX
   CPY #0          ; Compare Y register with 0
   BEQ done        ; Branch to done if equal
   DEY             ; Decrement Y register
   JMP loop        ; Jump back to loop

done:
   BRK             ; Exit program

draw_line:
   LDA $0400, X
   STA $0500, X
   LDA $0400, X+1
   STA $0500, X+1
   RTS             ; Return from subroutine
