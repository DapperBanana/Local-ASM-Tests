
START:
  LDA #<WORD_LIST
  STA PTR
  LDA #>WORD_LIST
  STA PTR+1

NEXT_WORD:
  JSR GET_NEXT_WORD

  CMP #0
  BEQ SENTENCE_DONE

  JSR PRINT_WORD

  JMP NEXT_WORD

SENTENCE_DONE:
  RTS

GET_NEXT_WORD:
  LDA (PTR),Y
  CMP #0
  BEQ END_OF_WORD

  INY
  RTS

END_OF_WORD:
  LDA #0
  RTS

WORD_LIST:
  .byte "The", 0
  .byte "quick", 0
  .byte "brown", 0
  .byte "fox", 0
  .byte "jumps", 0
  .byte "over", 0
  .byte "the", 0
  .byte "lazy", 0
  .byte "dog", 0

PRINT_WORD:
  LDY #0

PRINT_LOOP:
  LDA (PTR),Y
  CMP #0
  BEQ END_OF_PRINT

  JSR PRINT_CHAR

  INY
  JMP PRINT_LOOP

END_OF_PRINT:
  RTS

PRINT_CHAR:
  ; Add code here to print the character

  RTS
