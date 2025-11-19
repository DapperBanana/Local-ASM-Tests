
START    LDX #0              ; initialize index
         LDY #$FF            ; initialize common length
         LDA strings,X       ; load first string char
LOOP     CMP strings+1,X     ; compare with next string char
         BNE DONE            ; exit if not equal
         INX                 ; increment index
         CPX LEN             ; compare with string length
         BEQ DONE            ; exit if end of string
         BNE LOOP            ; continue comparing chars
DONE     DEY                 ; decrement common length
         CPY #0              ; check if common length is 0
         BNE DONE            ; continue if not 0

         ; common length found, output result
         LDX #0
OUTPUT   LDA strings,X       ; load character from common prefix
         BEQ END             ; exit if end of string
         JSR OUTPUTCHAR      ; output character
         INX                 ; increment index
         BNE OUTPUT           ; continue outputting characters
END      RTS

OUTPUTCHAR
         ; output character logic
         RTS

strings  .asciiz "apple"
         .asciiz "appletree"
         .asciiz "application"
LEN      = *-strings
