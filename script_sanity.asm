
.186C	LDA	#0		; Clear screen.
.186E	STA	$C000
.1871	STA	$C001
.1874	LDA	#$0D
.1876	STA	$C001		; Carriage return.
.1879	LDA	#<TEXT		; Print game instructions.
.187C	STA	$F000
.187F	LDA	#>TEXT
.1882	STA	$F001
.1885	JSR	$FFD2

LOOP	LDA	#<CHOICES	; Print choices: R, P, S.
	STA	$F000
	LDA	#>CHOICES
	STA	$F001
	JSR	$FFD2

	LDA	#$20		; Input player's choice.
	JSR	$FFCF
	LDA	$C000
	CMP	#$52		; Compare to R.
	BEQ	CHOSEN
	CMP	#$50		; Compare to P.
	BEQ	CHOSEN
	CMP	#$53		; Compare to S.
	BEQ	CHOSEN
	BRA	LOOP		; If invalid input, loop.

CHOSEN	LDA	#$20		; Generate random choice for computer.
	JSR	$FFD3
	AND	#$03
	CMP	#0
	BNE	ROCK
	CMP	#1
	BNE	PAPER

SCISSORS
	LDA	#<SCISSORS_TXT	; Print computer's choice.
	STA	$F000
	LDA	#>SCISSORS_TXT
	STA	$F001
	JSR	$FFD2
	BRA	RESULT

ROCK	LDA	#<ROCK_TXT
	STA	$F000
	LDA	#>ROCK_TXT
	STA	$F001
	JSR	$FFD2
	BRA	RESULT

PAPER	LDA	#<PAPER_TXT
	STA	$F000
	LDA	#>PAPER_TXT
	STA	$F001
	JSR	$FFD2

RESULT	LDA	$C000		; Check player's choice against computer's and display result.
	CMP	#$52		; Player chose R.
	BEQ	BOTH_ROCK
	CMP	#$50		; Player chose P.
	BEQ	BOTH_PAPER
	CMP	#$53		; Player chose S.
	BEQ	BOTH_SCISSORS
	BRA	LOOP		; Invalid input.

BOTH_ROCK	LDA	#<DRAW_TXT	; R vs R.
	STA	$F000
	LDA	#>DRAW_TXT
	STA	$F001
	JSR	$FFD2
	BRA	LOOP

BOTH_PAPER	LDA	#<DRAW_TXT	; P vs P.
	STA	$F000
	LDA	#>DRAW_TXT
	STA	$F001
	JSR	$FFD2
	BRA	LOOP

BOTH_SCISSORS	LDA	#<DRAW_TXT	; S vs S.
	STA	$F000
	LDA	#>DRAW_TXT
	STA	$F001
	JSR	$FFD2
	BRA	LOOP

ROCK_TXT	.TEXT	"Computer chose ROCK"
PAPER_TXT	.TEXT	"Computer chose PAPER"
SCISSORS_TXT	.TEXT	"Computer chose SCISSORS"
DRAW_TXT	.TEXT	"It's a draw!"

TEXT		.TEXT	"Choose R for ROCK, P for PAPER, S for SCISSORS"
CHOICES		.TEXT	"RPS"
