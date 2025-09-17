
START	LDX #18		; load X register with 18 (counter)
	LDA NUMBER1		; load first number into accumulator
	STA NUM1		; store in NUM1
	LDA NUMBER2		; load second number into accumulator
	STA NUM2		; store in NUM2

LOOP 	LDA NUM1		; load NUM1 into accumulator
	CMP NUM2		; compare with NUM2
	BEQ EXIT		; branch if equal to exit
	BEQ ENDLOOP	; branch if equal to end of loop
	BCC LESS		; branch if accumulator is less than NUM2
	SBC NUM2		; subtract NUM2 from accumulator
	STA NUM1		; store the result in NUM1
	BRA LOOP		; branch back to start of loop

LESS	LDA NUM2		; load NUM2 into accumulator
	SBC NUM1		; subtract NUM1 from accumulator
	STA NUM2		; store the result in NUM2
	BRA LOOP		; branch back to start of loop

ENDLOOP	LDA NUM1		; load NUM1 into accumulator
	LDX #0		; load X with zero
EXIT 	STA GCD		; store GCD at GCD location
