
      ORG $0400

START LDX #$00       ; Initialize index to 0
LOOP  LDA TABLE,X    ; Load value from table
      STA $00C0,X    ; Store value in memory
      INX            ; Increment index
      CPX #$10       ; Check if index reached end of sentence
      BEQ EOL        ; If so, end of sentence
      JMP LOOP       ; Otherwise continue looping
      
EOL   RTS            ; Return from subroutine

TABLE .BYTE "The", 0
      .BYTE "quick", 0
      .BYTE "brown", 0
      .BYTE "fox", 0
      .BYTE "jumps", 0
      .BYTE "over", 0
      .BYTE "the", 0
      .BYTE "lazy", 0
      .BYTE "dog", 0
      .BYTE 0

      .ORG $0FF6
      .WORD START
