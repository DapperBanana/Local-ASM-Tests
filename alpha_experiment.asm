
.INCLUDE "vcs.h"

	ORG $F000

Start:
	LDX #$00             ; Initialize X register to 0
	LDA $00              ; Load n from memory location $00
	CLC                  ; Clear carry flag
SumLoop:
	ADC X                ; Add X to accumulator
	INX                  ; Increment X
	CPX $00              ; Compare X to n
	BNE SumLoop          ; If X is not equal to n, loop
	
	STA $01              ; Store the sum in memory location $01
	
	; Display the result
	LDA $01              ; Load the sum from memory location $01
	STA WSYNC            ; Wait for vertical sync
	STA GRP0             ; Display the sum in player 0 graphics register
	
	; End of program
	HLT                  ; Halt the program

	ORG $FFFA
	WORD Start            ; Set NMI vector to Start address
	WORD $0000            ; Set RESET vector to $0000
