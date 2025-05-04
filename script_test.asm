
         .org $0200

start    LDX #numCount    ; Load number of numbers into X register
         LDY #numList     ; Load address of number list into Y register
         JSR LCM           ; Jump to LCM subroutine
         STA result       ; Store result in memory
         BRK              ; Break

LCM      CPX #1           ; Check if last number in list
         BEQ done         ; If last number, exit subroutine
         LDA (Y),X        ; Load next number into accumulator
         JSR calculateLCM ; Calculate LCM
         DEX              ; Decrement X register
         INY              ; Increment Y register
         JMP LCM          ; Jump back to LCM subroutine

calculateLCM
         PHA              ; Push accumulator onto stack
         LDA result       ; Load previous result
         STA tempResult   ; Store in temporary variable
         LDA #0           ; Load 0 into accumulator
         STA result       ; Initialize result to 0
         whileLoop
         LDX tempResult   ; Load temporary result into X register
         CMP #result      ; Compare with current result
         BNE increase     ; If not equal, increase result
         LDA result       ; Load current result
         CLC              ; Clear carry flag
         ADC tempResult   ; Add temporary result
         STA result       ; Store in result
         increase
         INC result       ; Increase result by 1
         BCC whileLoop    ; Branch if carry flag is clear
         PLA              ; Pull accumulator from stack
         RTS              ; Return from subroutine

numCount .byte 4
numList  .byte $07, $0B, $0C, $16
result   .byte 0
tempResult .byte 0

         .end
