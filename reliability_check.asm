
LDA #$00        ; initialize accumulator
LDX #$09        ; initialize index register

loop:
LDA string,X    ; load character from string
CMP #$30        ; check if character is a digit
BEQ valid_digit ; branch if it is a digit
CMP #$58        ; check if character is the end of the string
BEQ valid_ISBN  ; branch if it is the end of the string
JMP invalid_ISBN   ; branch if it is not a valid character

valid_digit:
DEX             ; decrement index
CMP #$58        ; check if end of string
BEQ valid_ISBN  ; branch if end of string
BEQ loop        ; branch back to loop
BPL loop        ; branch back to loop

valid_ISBN:
LDA #$01        ; set accumulator to 1 if valid ISBN
BRK             ; exit program

invalid_ISBN:
LDA #$00        ; set accumulator to 0 if not valid ISBN
BRK             ; exit program

string:
DB "123456789X",0   ; example string, change as needed
