
START    LDA #00        ; Initialize accumulator to 0
         STA MAX_VALUE  ; Initialize max value to 0
         STA MIN_VALUE  ; Initialize min value to 0

LOOP     LDA INDEX      ; Load the dictionary index
         CMP #NUM_VALUES; Compare with the total number of values
         BEQ END_LOOP    ; If equal, end loop
         
         LDX INDEX      ; Load index into X register
         LDA DICT,X     ; Load the value from the dictionary
         
         ; Check if the value is greater than the current max value
         CMP MAX_VALUE   ; Compare value with max value
         BCC NOT_MAX     ; Branch if not greater
         STA MAX_VALUE   ; Update max value
         
NOT_MAX  ; Check if the value is less than the current min value
         CMP MIN_VALUE   ; Compare value with min value
         BCS NOT_MIN     ; Branch if not smaller
         STA MIN_VALUE   ; Update min value
         
NOT_MIN  INX             ; Increment index
         INC INDEX
         JMP LOOP        ; Repeat loop

END_LOOP ; End of loop, max and min values are now in MAX_VALUE and MIN_VALUE respectively

         ; Your code here
         
MAX_VALUE .BYTE 00       ; Variable to store maximum value
MIN_VALUE .BYTE 00       ; Variable to store minimum value
INDEX     .BYTE 00       ; Current index in dictionary array
NUM_VALUES .EQ $05       ; Total number of values in dictionary
DICT      .BYTE $FF,$0A,$32,$14,$7F,$24,$E6,$A3 ; Sample dictionary data
