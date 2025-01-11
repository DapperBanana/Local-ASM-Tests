
; Tic-Tac-Toe
; 6502 Assembly program to simulate a basic text-based Tic-Tac-Toe game
; Player plays against the computer

; Console variables
RESP	= $FFD2 		; Output a character to screen
CHIN	= $FFCF 		; Read a character from keyboard

; Game variables
Board 	= $00	 		; Tic-Tac-Toe board
Turn	= $01			; Player's turn (0 = player, 1 = computer)
Winner	= $02			; Winner flag (1 = player, 2 = computer, 3 = tie)
Move	= $03			; Player move
Msg	= $06			; Message buffer
CRLF	= $0D0A			; Carriage return / linefeed

; Constants
PC	= $C000			; Program start address
RANDOM	= $BEEF			; Random number seed

		ORG	PC
		LDX	#0			; Initialize board
		LDA	#32			; Space character
INITL		STA	Board,X
		INX
		CPX	#9
		BNE	INITL

		LDA	#1			; Player goes first
		STA	Turn

		JSR	PrintBoard		; Print initial board

GAMELOOP	LDA	Turn
		BEQ	PLAYER		; Player's turn
		JSR	COMPUTER	; Computer's turn
		BCC	GAMELOOP	; Repeat game loop

ENDGAME	JSR	PrintBoard		; Print final board
		JSR	PrintMessage
		JSR	ExitGame

PLAYER	JSR	GetPlayerMove	; Get player move
		JSR	MoveIsValid
		BCC	PLAYER

		LDA	Move
		STA	Board,X
		LDA	Turn
		EOR	#1
		STA	Turn

		JSR	PrintBoard

		JSR	CheckWinner
		BNE	ENDGAME

		BNE	GAMELOOP	; Repeat game loop

COMPUTERJSR	GetComputerMove	; Get computer move
		JSR	MoveIsValid
		BCC	COMPUTER

		LDA	Move
		STA	Board,X
		LDA	Turn
		EOR	#1
		STA	Turn

		JSR	PrintBoard

		JSR	CheckWinner
		BNE	ENDGAME

		BNE	GAMELOOP	; Repeat game loop

PrintBoard
		LDX	#0
		LDA	#CRLF
		JSR	PrintChar

PBLOOP		LDA	Board,X
		CPX	#2
		BEQ	PBROW1
		CPX	#5
		BEQ	PBROW2

		LDA	#32		; Space character
		JSR	PrintChar

		JSR	PrintVertBar
		INX
		BPL	PBLOOP

PBROW1		LDA	Board,X
		JSR	PrintChar
		JSR	PrintVertBar
		JSR	PrintChar
		JSR	PrintVertBar
		INX
		JSR	PrintChar

		JSR	PrintVertBar
		INX
		JSR	PrintChar

		LDA	#CRLF
		JSR	PrintChar
		RTS

PBROW2		LDA	Board,X
		JSR	PrintChar
		JSR	PrintVertBar
		JSR	PrintChar
		JSR	PrintVertBar
		INX
		JSR	PrintChar

		JSR	PrintVertBar
		INX
		JSR	PrintChar

		LDA	#CRLF
		JSR	PrintChar
		RTS

PrintVertBar
		LDA	#124		; Vertical bar character
		JSR	PrintChar
		RTS

PrintChar
		STA	RES				; Display character
PCCHAR		LDA	#RESP			; Wait for key press
		JSR	$FFD2
		LDA	CHIN			; Get key press
		CMP	#13			; Check for Enter key
		BEQ	PCCHAR
		RTS

ExitGame
		RTS

PrintMessage
		LDY	Winner
		LDA	Msg,Y
		JSR	PrintString
		JSR	PrintChar
		RTS

PrintString
		STA	RES
STRLOOP		INY
		LDA	Msg,Y
		CMP	#$FF
		BEQ	PMsgDone
		JSR	PrintChar
		BNE	PMsgLoop
PMsgDone	RTS

GetPlayerMove
		LDA	#MSG_PLAYER_MOVE
		JSR	PrintMessage
		JSR	GetInput
		RTS

GetComputerMove
		LDA	#MSG_COMPUTER_MOVE
		JSR	PrintMessage

		; Computer goes for a random move
		LDA	RANDOM
		AND	#7
		STA	Move
		RTS

GetInput
		LDA	CHIN
		STA	Move
		RTS

MoveIsValid
		LDX	Move
		LDA	Board,X
		CMP	#32
		BNE	MINVAL1
		LDA	#MSG_INVALID_MOVE
		JSR	PrintMessage
		SEC
		RTS

MINVAL1		JSR	CheckBounds
		BCC	MINVAL2
		JSR	CheckBounds
		BCC	MINVAL3
		SEC
		RTS

MINVAL2		LDA	#MSG_INVALID_MOVE
		JSR	PrintMessage
		SEC
		RTS

MINVAL3		LDA	#MSG_INVALID_MOVE
		JSR	PrintMessage
		SEC
		RTS

CheckBounds
		CPX	#9
		BCS	OTOF
		RTS

OTOF		SEC
		RTS

CheckWinner
		LDX	#0
		LDA	Board,X
		CPX	#2
		BEQ	CHECKWIN1
		CPX	#4
		BEQ	CHECKWIN1
		CPX	#6
		BEQ	CHECKWIN1

		INX
		LDA	Board,X
		CPX	#1
		BEQ	CHECKWIN1
		CPX	#4
		BEQ	CHECKWIN1
		CPX	#7
		BEQ	CHECKWIN1

		LDX	#0
		LDA	Board,X
		CMP	Board+4
		BNE	CHECKWIN2
		CMP	Board+8
		BNE	CHECKWIN2
		LDX	#1
CHECKWIN2	LDA	Board,X
		CMP	Board+1
		BNE	CHECKWIN3
		CMP	Board+4
		BNE	CHECKWIN3
		LDX	#2
CHECKWIN3	LDA	Board,X
		CMP	Board+1
		BNE	CHECKWIN4
		CMP	Board+2
		BNE	CHECKWIN4
		RTS

CHECKWIN4	LDA	#1
		STA	Winner
		RTS

CHECKWIN1	LDA	#2
		STA	Winner
		RTS

MSG_PLAYER_MOVE	.BYTE	"P1: Enter move (1-9) -> ", $FF
MSG_COMPUTER_MOVE .BYTE	"Comp: Thinking...", $FF
MSG_INVALID_MOVE .BYTE	"Invalid move!", $FF

		END
