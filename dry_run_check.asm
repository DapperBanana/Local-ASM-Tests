
START:
  LDA #0
  STA DISTANCE
  LDA #0
  STA I
  LDA #0
  STA J
  
LOOP1:
  LDA STR1, X
  BEQ DONE
  
  LDA #0
  STA J
  
LOOP2:
  LDA STR2, Y
  BEQ NEXT
  
  CMP STR1, X
  BNE NOT_EQUAL
  
  LDA DISTANCE
  INY
  STA DISTANCE
  JMP NEXT

NOT_EQUAL:
  LDA DISTANCE
  INX
  INY
  INY
  STA DISTANCE

NEXT:
  INY
  LDA J
  STA J
  INX
  LDA I
  CMP STR2, Y
  BMI LOOP2
  
  LDA DISTANCE
  INX
  STA DISTANCE
  
  INX
  LDA I
  STA I
  JMP LOOP1

DONE:
  ... ; code to handle the result
  
STR1:
  .asciiz "STRING1"
  
STR2:
  .asciiz "STRING2"
  
DISTANCE:
  .byte 0
  
I:
  .byte 0
  
J:
  .byte 0
