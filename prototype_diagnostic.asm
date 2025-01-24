
; 6502 Assembly program to check if a given string is a valid URL

	Processor 6502
	.include "vcs.h"

	.segment "BEG"

start:
	LDX #0        ; Initialize X register
	LDY #0        ; Initialize Y register
	LDZ #0        ; Initialize Z register

	; Read string into memory
readLoop:
	LDA INPT,X    ; Read next character from input
	BNE checkChar ; Check if end of string
	STA STRBUF,Y  ; Store character in buffer
	INX           ; Increment input pointer
	INY           ; Increment buffer pointer
	BRA readLoop  ; Continue reading characters

checkChar:
	LDA STRBUF,Z  ; Load current character from buffer
	CMP #' '      ; Check for space character
	BEQ endString ; String is finished if space is found
	CMP #'A'      ; Check if character is in valid range
	BEQ validChar
	CMP #'a'
	BEQ validChar
	CMP #'0'
	BEQ validChar
	CMP #':'
	BEQ validChar
	CMP #'/'
	BEQ validChar
	CMP #'.'  
	BEQ validChar
 
invalidChar:
	; Invalid character found, set carry flag
	CLC
	RTS

validChar:
	INZ           ; Increment Z register
	BRA checkChar ; Continue checking characters

endString:
	; URL has passed validation, clear carry flag
	SEC
	RTS

STRBUF: .BLKB 255     ; Buffer to store input string

	.segment "END"
