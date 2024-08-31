
ORG $2000

START LDX #$00         ; Initialize index to 0
      LDY #$00

LOOP  LDA INPUT,X      ; Load character from input string
      CMP #$20         ; Check if character is a space
      BEQ SKIP_SPACE   ; If it is a space, skip to next character
     
      CMP #$41         ; Check if character is a letter (lower case)
      BCC SKIP         ;
      CMP #$5A         ; Check if character is a letter (upper case)
      BCC SKIP         ;
      CMP #$61         ; Check if character is a letter (lower case)
      BCC SKIP         ;
      CMP #$7A         ; Check if character is a letter (upper case)
      BCC SKIP         ;
      JMP REMOVE_CHAR  ; If none of the above, remove the character

SKIP  INX              ; Move to next character
      BNE LOOP         ; Continue processing loop

END   RTS

REMOVE_CHAR
      LDA #$20         ; Replace character with space
      STA OUTPUT,Y
      INY              ; Move to next output index
      JMP LOOP

SKIP_SPACE
      INX              ; Move to next character
      JMP LOOP

INPUT .BYTE "Hello, world!", 0
OUTPUT .BLKW 20

      END START
