
SEPARATOR .BLOCK 1 ;separator between strings
BEGIN LDX #0 ;initialize index for string 1
 LDY #0 ;initialize index for string 2
 LOOP LDA STR1,X ;load character from string 1
 CMP #0 ;check for end of string
 BEQ FINISH ;if end of string, finish
 STX PTR ;store pointer
 CHECK LDA STR2,Y ;load character from string 2
 CMP #0 ;check for end of string
 BEQ NEXT ;if end of string, move to next character in string 1
 CMP STR1,X ;compare characters
 BEQ FOUND ;if characters are equal, found common character
 INY ;move to next character in string 2
 JMP CHECK ;repeat comparison
 FOUND LDA STR1,X ;load common character
 JSR PRINT ;print character
 LDX PTR ;move to next character in string 1
 INX
 STX PTR
 INY ;move to next character in string 2
 JMP LOOP ;repeat process
 NEXT INX ;move to next character in string 1
 JMP LOOP
 FINISH RTS ;end of program
 STR1 .BYTE "HELLO",0 ;first string
 STR2 .BYTE "WORLD",0 ;second string
 PTR .BYTE 0 ;pointer to current character in string 1
 PRINT LDA #02 ;output character
 JSR $FFD2 ;print character
 RTS ;end of subroutine
