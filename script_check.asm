
RESET_ADDRESS = $FFFC
ORG $0200

START_ADDRESS:    LDX #0              ; Load X register with index 0
                  LDY #0              ; Load Y register with index 0
                  LDA #0              ; Initialize current longest sequence length to 0
                  STA LONGEST_SEQ
                  LDA #0              ; Initialize current sequence length to 0
                  STA CURRENT_SEQ
LOOP:             LDA NUMBERS, X      ; Load the current number from the list
                  BNE CHECK_SEQ       ; Branch if number is not 0 (end of list)
                  JMP END             ; Jump to end of program
CHECK_SEQ:        CMP NUMBERS+1, X    ; Compare with next number in the list
                  BEQ INCREMENT_SEQ   ; Branch if consecutive numbers
                  CMP CURRENT_SEQ, Y  ; Compare current sequence length with longest sequence length
                  BCC UPDATE_SEQ       ; Branch if current sequence length is greater
                  LDA CURRENT_SEQ      ; Update longest sequence length
                  STA LONGEST_SEQ
                  LDA #0               ; Reset current sequence length
                  STA CURRENT_SEQ
INCREMENT_SEQ:    INY                  ; Increment Y register
                  INC CURRENT_SEQ      ; Increment current sequence length
                  INX                  ; Increment X register
                  JMP LOOP             ; Continue looping through list
UPDATE_SEQ:       STA LONGEST_SEQ      ; Update longest sequence length
                  LDA #0               ; Reset current sequence length
                  STA CURRENT_SEQ
                  JMP LOOP             ; Continue looping through list
END:              BRK

NUMBERS:          .BYTE $01, $02, $03, $04, $06, $07, $08, $09, $0A, $0B, $0C, $0F, $10, $11, $15, $16, $17, $1A, $1B, $1C, $1D, $1E, $00

LONGEST_SEQ:      .BYTE 0
CURRENT_SEQ:      .BYTE 0

ORG RESET_ADDRESS
                  .WORD START_ADDRESS

