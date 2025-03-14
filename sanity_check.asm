
; 6502 Assembly program to find the longest common subsequence of two strings

; Input:
; String1: $3000 onwards
; String2: $3100 onwards

; Output:
; Length of longest common subsequence in X register

LDA #$00  ; initialize counter for common subsequence length
LDX #$00  ; initialize index for string1
LDY #$00  ; initialize index for string2

loop:
LDA $3000,X  ; load character from string1
CMP #$00    ; check if end of string1
BEQ end     ; if end of string1, exit loop

STA $3200,X  ; store character from string1 to temporary buffer
LDA $3000,X  ; load character from string1
STA $3300,X  ; store character from string1 to temporary buffer

LDA #$00    ; initialize index for string1
LDA #$00    ; initialize index for string2

inner_loop:
LDA $3100,Y  ; load character from string2
CMP #$00    ; check if end of string2
BEQ compare ; if end of string2, compare and update common subsequence length

CMP $3200,X ; compare characters from string1 and string2
BNE next   ; if characters do not match, go to next character in string2

INX         ; increment index for string1
INY         ; increment index for string2

BRA inner_loop  ; loop back

compare:
CPX #$00    ; check if end of string1
BEQ next    ; if end of string1, go to next character in string1

CPY #$00    ; check if end of string2
BEQ next    ; if end of string2, go to next character in string2

INC $3400   ; increment common subsequence length

next:
INY         ; increment index for string2
CPY #$00    ; check if end of string2
BNE inner_loop  ; if not end of string2, loop back

INC X       ; increment index for string1
LDX #$00    ; reset index for string1
BRA loop    ; loop back

end:
LDX $3400   ; load common subsequence length into X register
