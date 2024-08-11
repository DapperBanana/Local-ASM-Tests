
START     LDA #$00        ; Initialize index to 0
          STA INDEX

LOOP      LDA STR1,X     ; Load character from first string
          BEQ DONE       ; If end of string, exit loop
          STA CHAR1

          LDA #$00       ; Reset index for second string
          STA INDEX2

CHECK     LDA STR2,X     ; Load character from second string
          BEQ NEXT       ; If end of second string, go to next character in first string
          STA CHAR2

          CMP CHAR1      ; Compare characters
          BEQ PRINT      ; If characters are equal, print character and continue
          
NEXT      INX             ; Move to next character in second string
          INX
          JMP CHECK      ; Check next character

PRINT     LDA CHAR1        ;Print common character
          JSR $FDED         ;Print character

NEXT1     INX              ; Move to next character in first string
          INX
          JMP LOOP         ; Check next character

DONE      RTS

INDEX     .BYTE $00

INDEX2    .BYTE $00

CHAR1     .BYTE $00

CHAR2     .BYTE $00

          .ORG $2000
STR1      .BYTE "HELLO",0
STR2      .BYTE "WORLD",0
