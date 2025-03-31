
START    LDX #$00      ; Load X register with 0
         LDY #$00      ; Load Y register with 0
         LDA VALUE,X  ; Load accumulator with first value in dictionary
         STA MAX       ; Store accumulator in memory location for max value
         STA MIN       ; Store accumulator in memory location for min value

LOOP     INX           ; Increment X register
         LDA VALUE,X  ; Load accumulator with next value in dictionary
         CMP MAX       ; Compare value with current max value
         BCC NOT_MAX   ; Branch if value is less than max value
         STA MAX       ; Store value as new max value
NOT_MAX  CMP MIN       ; Compare value with current min value
         BCS NOT_MIN   ; Branch if value is greater than min value
         STA MIN       ; Store value as new min value
NOT_MIN  CPX #$FF      ; Compare X register with 255 (end of dictionary)
         BNE LOOP      ; Branch back to LOOP if end of dictionary not reached
         
         ; Program ends here
         BRK

MAX      .BYTE $00     ; Memory location to store max value
MIN      .BYTE $00     ; Memory location to store min value

VALUE    .BYTE $10,$20,$05,$30,$15    ; Example dictionary values
