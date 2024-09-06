
START    LDX #$00         ; Initialize the index for list 1
         LDY #$00         ; Initialize the index for list 2
         
COMPARE  LDA LIST1, X    ; Load the value from list 1
         CMP LIST2, Y    ; Compare with the value from list 2
         BEQ FOUND       ; If the values are equal, jump to FOUND
         
NEXT1    INX             ; Move to the next element in list 1
         CPX #LENGTH1    ; Check if end of list 1 is reached
         BNE COMPARE     ; If not, compare the next element
         
         RTS             ; If end of list 1 is reached, return
         
FOUND    STA RESULT, X   ; Store the common element in RESULT
         INX             ; Move to the next element in the result
         
         INY             ; Move to the next element in list 2
         CPY #LENGTH2    ; Check if end of list 2 is reached
         BNE COMPARE     ; If not, compare the next element
         
         RTS             ; If end of list 2 is reached, return
         
LIST1    .BYTE $01, $02, $03, $04, $05
LENGTH1  = * - LIST1
         
LIST2    .BYTE $03, $04, $05, $06, $07
LENGTH2  = * - LIST2
         
RESULT   .DS.B 5         ; Space to store the result list
         
         .END
