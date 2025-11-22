
LDA #$02    ; Open file for reading
LDX #file   ; Filename - "data.txt"
JSR $FFD5   ; Open file

LDX #$00    ; Read data from file
JSR $FFD7   ; Read file

LDA $02     ; Print data
JSR $FFD2   ; Print character

INX
CMP #$00
BNE loop

RTS

file: .db "data.txt", $00  ; Filename

.data:  .asciiz ""
