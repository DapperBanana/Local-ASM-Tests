
.INCLUDE "vcs.h"

TEMP EQU $80

.ORG $F000
START LDX #1 ; Initialize X register to 1 (day of the month)
LOOP LDA #<CALENDARTEXT ; Load the low byte of the address of "CALENDARTEXT" into the accumulator
      LDY #>CALENDARTEXT ; Load the high byte of the address of "CALENDARTEXT" into the Y register
      JSR VOUT ; Call the VOUT routine to print the text at the address pointed to by the accumulator and Y register
      LDA #$20 ; Load the ASCII code for space into the accumulator
      JSR VOUT ; Call the VOUT routine to print a space
      INX ; Increment X register to move to the next day
      CPX #32 ; Check if we have reached the end of the month
      BEQ DONE ; If X register is 32, jump to DONE
      BNE LOOP ; If X register is not 32, jump back to LOOP to print the next day
DONE BRK ; Break (end program)
CALENDARTEXT .BYTE "1", $00, "2", $00, "3", $00, "4", $00, "5", $00, "6", $00, "7", $00, "8", $00, "9", $00, "10", $00, "11", $00, "12", $00, "13", $00, "14", $00, "15", $00, "16", $00, "17", $00, "18", $00, "19", $00, "20", $00, "21", $00, "22", $00, "23", $00, "24", $00, "25", $00, "26", $00, "27", $00, "28", $00, "29", $00, "30", $00, "31", $00

.END
