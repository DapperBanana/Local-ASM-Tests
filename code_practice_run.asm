
; Edit Distance Calculator

.INCLUDE "vcs.h"

.ORG $0800

text1  .BYTE "KITTEN", 0
text2  .BYTE "SITTING", 0
result .BYTE 0

START         LDX #0
              LDY #0
              LDA #0
LOOP          LDA text1,X
              CMP #0
              BEQ DONE
              LDX #0
INNER         LDA text2,Y
              CMP #0
              BEQ NEXT
              CMP text1,X
              BEQ EQUAL
              JSR EDIT
EQUAL         INX
              INY
              JMP INNER
EDIT          INY
              INC result
              JMP INNER
NEXT          INX
              LDX #0
              JMP LOOP
DONE          BRK

.END
