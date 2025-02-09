
START	LDA #10		; Load first number into accumulator
	STA NUM1

	LDA #15		; Load second number into accumulator
	STA NUM2

	JSR LCM		; Call LCM subroutine

	HLT			; Halt program

LCM		LDY #1		; Initialize Y register to 1

CHECK		LDA NUM1		; Load first number into accumulator
	CMP NUM2		; Compare with second number
	BEQ DONE		; If equal, jump to done

	MULT		LDA NUM2	; Load second number into accumulator
	CLC			; Clear carry flag for addition
	ADC NUM1		; Add first number to accumulator
	STA NUM2		; Store result in second number

	INY			; Increment Y register
	JMP CHECK		; Go back to check condition

DONE		RTS			; Return from subroutine

NUM1		.byte 0		; First number
NUM2		.byte 0		; Second number

		.end		; End of program
