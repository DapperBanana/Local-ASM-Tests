
START	LDX	#0		reset index
	LDY	#1000		initialize divisor
	LDA	#942		initialize number to convert
	STA	NUMBER
LOOP	LDA	NUMBER		get current value
	CMP	ROMAN,Y	check if it is less than current divisor
	BCC	LESS
	MVX	1000/Y		load divisor
	JSR	PRINT		print current numeral
	SEC
	SBC	ROMAN,Y	subtract current numeral
	STA	NUMBER	save new value
	BMI	LOOP
LESS	DEY		decrement divisor
	BPL	LOOP
	RTS		return to caller

ROMAN	DCB	"M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I",0

PRINT	LDY	#0		reset index
PRINT_LOOP
	LDA	ROMAN,Y		get current character
	CMP	#0		check for end of string
	BEQ	PRINT_DONE
	STA	CHAR		save character to print
	JSR	PRINT_CHAR	print character
	INY		increment index
	JMP	PRINT_LOOP
PRINT_DONE
	RTS		return

PRINT_CHAR
	JSR	CHAROUT		print character to screen
	RTS

CHAROUT	LDA	CHAR		get character to print
	STA	OUTBUF		store it in output buffer
	JSR	PRINTCHAR	output character to screen
	CLC			clear carry to signal no error
	RTS		exit

OUTBUF	DSB	1		output buffer for character to print
CHAR	DSB	1		character to print
NUMBER	DSW	1		number to convert
