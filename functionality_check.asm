
ORG $1000 ; starting address

START:
  LDX #0 ; initialize index register
  LDA email_str,X ; load first character of the string
  CMP #'@' ; check if it is '@'
  BNE NOT_VALID_EMAIL ; branch if not '@'
  
LOOP:
  INX ; increment index register
  LDA email_str,X ; load next character of the string
  
  CMP #'@' ; check if it is '@' again
  BEQ NOT_VALID_EMAIL ; branch if another '@' found
  
  CMP #'.' ; check if it is '.' character
  BEQ VALID_EMAIL ; branch if '.' found
  
  CMP #' ' ; check if it is space character
  BEQ NOT_VALID_EMAIL ; branch if space found
  
  CMP #0 ; check if end of string reached
  BEQ VALID_EMAIL ; branch if end of string, email is valid
  
  JMP LOOP ; otherwise, continue loop

NOT_VALID_EMAIL: 
  LDA #0 ; invalid email address found
  STA $0200 ; store result in memory address $0200
  BRK ; break execution

VALID_EMAIL:
  LDA #1 ; valid email address found
  STA $0200 ; store result in memory address $0200
  BRK ; break execution

email_str: .asciiz "example@example.com" ; change this to test different email addresses

.END
