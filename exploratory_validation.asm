
START     NOP
  
          LDX #0          ; Initialize index to 0
          LDY #0          ; Initialize max length to 0
  
LOOP      LDA SENTENCE,X ; Load character at index X
          CMP #32         ; Compare with space character
          BEQ CHECK_LENGTH; If space character, check length
          CMP #0          ; Check for end of string
          BEQ END         ; If end of string, exit
          INX             ; Increment index
          JMP LOOP        ; Continue loop
  
CHECK_LENGTH
          CPY X           ; Compare max length with current word length
          BCC UPDATE      ; If current word is longer, update max length
          INX              ; Skip over space character
          LDA #0           ; Reset word length to 0
          JMP LOOP         ; Continue loop
  
UPDATE    LDA X          ; Update max length with current word length
          STA Y
          INX
          JMP LOOP
  
END       LDA Y          ; Get the length of the longest word
          BRK

SENTENCE  .ASC "This is a sample sentence for testing the program." ; Input sentence

          .ORG $FFFA
          .WORD START     ; Reset vector
          .WORD START     ; IRQ vector
          .WORD START     ; NMI vector
          .WORD START     ; BRK vector
