
; Tic-Tac-Toe Game

; Define constants
.equ BOARD_SIZE, 3
.equ EMPTY, '-'
.equ X_MARKER, 'X'
.equ O_MARKER, 'O'

; Define variables
.board:	.byte BOARD_SIZE*BOARD_SIZE
.marker:	.byte X_MARKER
.turn:	.byte 0

; Main program
.start:
	lda #EMPTY		; Load empty marker '-'
	sta .marker		; Store it in marker variable
	sei			; Disable interrupts
	lda #BOARD_SIZE		; Load board size
	sta .turn		; Store it in turn variable
	jsr display_board	; Display initial board
	jsr game_loop		; Start game loop

	; Game over
	lda #32
	jsr $fdda		; Print space
	lda #32
	jsr $fdda		; Print space
	lda #32
	jsr $fdda		; Print space
	lda #32
	jsr $fdda		; Print space
	lda #32
	jsr $fdda		; Print space
	ldx .marker		; Load winner marker
	cpx X_MARKER		; Check if X has won
	beq x_won		; If yes, jump to X_WON
	jmp o_won		; Otherwise, jump to O_WON

x_won:
	; Print X has won
	lda #"X"
	jsr $fdda
	; Print message
	lda #" has won!"
	jsr $fdda
	jmp end_game

o_won:
	; Print O has won
	lda #"O"
	jsr $fdda
	; Print message
	lda #" has won!"
	jsr $fdda
	jmp end_game

end_game:
	; Print newline
	lda #13
	jsr $fdda
	cli			; Enable interrupts
	rts			; Return to caller

; Game loop
game_loop:
	lda #X_MARKER		; Load X marker
	sta .marker		; Store it in marker variable
.loop_x:
	jsr player_move		; X player move
	jsr check_win		; Check if X has won
	bne .end_x		; If X has won, end X turn
	lda .turn		; Load turn counter
	clc
	adc #1			; Increment turn counter
	sta .turn		; Store back in turn counter
	lda .turn		; Check if turn counter is at max
	cmp #9
	beq .draw		; If yes, jump to DRAW
	lda #O_MARKER		; Load O marker
	sta .marker		; Store it in marker variable
	jsr player_move		; O player move
	jsr check_win		; Check if O has won
	bne .end_o		; If O has won, end O turn
	lda .turn		; Load turn counter
	clc
	adc #1			; Increment turn counter
	sta .turn		; Store back in turn counter
	jmp .loop_x		; Repeat loop

.draw:
	; Print DRAW message
	lda "D"
	jsr $fdda
	lda "R"
	jsr $fdda
	lda "A"
	jsr $fdda
	lda "W"
	jsr $fdda
	jmp end_game

.end_x:
	; X has won
	lda #1
	rts

.end_o:
	; O has won
	lda #1
	rts

; Display tic-tac-toe board
display_board:
	lda #13
	jsr $fdda		; Print newline
	lda #"---------"	; Initial board layout
	ldy #0
.loop_display:
	lda .board,y		; Load board element
	cmp #0			; Compare to empty space
	beq .print_empty	; If empty, print empty space
	jsr $fdda		; Otherwise, print marker
	lda $"|"
	jsr $fdda		; Print separator
.increase_y:
	iny
	lda #3
	cmp y
	bne .loop_display	; Continue loop for 3x3 board
	lda #13
	jsr $fdda		; Print newline
	rts

.print_empty:
	lda #" "
	jsr $fdda		; Print empty space
	jmp .increase_y

; Get player move
player_move:
	display_board		; Display current board
	lda .marker		; Load player marker
	jsr $fdda		; Print player marker
	lda #" enter row (0-2) and column (0-2): "
	jsr $fdda		; Print message
	jsr $ffd2		; Get player input
	cmp #"0"		; Check if input is between 0-2
	bcc player_move
	cmp #"2"
	bcs player_move
	cmp #"1"
	bne next_input
	cmp #"0"
	bcs done_input
	player_move
next_input:
	lda #13
	jsr $fdda		; Print newline
	jsr $fdda		; Print newline
	jmp player_move
done_input:
	sec			; Convert ASCII to decimal
	sbc #"0"
	pha			; Save column
	jsr $ffd2		; Get player input
	sec			; Convert ASCII to decimal
	sbc #"0"
	tax			; Save row
	pla			; Load column
	asl
	asl
	asl
	asl
	adc x			; Calculate address
	sta .board,x		; Store player move in board
	rts

; Check if player has won
check_win:
	ldx .marker		; Load player marker
	lda theBoard+0
	cmp x				; Check first row
	bne .next
	lda theBoard+1
	cmp x
	bne .next
	lda theBoard+2
	cmp x
	bne check_col
	jmp .end

.next:
	lda theBoard+3
	cmp x				; Check second row
	bne .next2
	lda theBoard+4
	cmp x
	bne .next
	lda theBoard+6
	cmp x
	bne check_col
	jmp .end

.next2:
	lda theBoard+6		
	cmp x				; Check third row
	bne .end				  
	lda theBoard+7
	cmp x
	bne .end				  
	lda theBoard+8
	cmp x
	bne .end				  
	jmp .end

check_col:
	lda theBoard+0
	cmp x				; Check first column
	beq .next3
	lda theBoard+3
	cmp x
	beq .next3
	lda theBoard+6
	cmp x
	bne check_diag
	jmp .end

.next3:
	lda theBoard+1
	cmp x				; Check second column
	beq .next4
	lda theBoard+4
	cmp x
	beq .next4
	lda theBoard+7
	cmp x
	bne check_diag
	jmp .end

.next4:
	lda theBoard+2	
	cmp x				; Check third column
	beq .next5
	lda theBoard+5
	cmp x
	beq .next5
	lda theBoard+8
	cmp x
	bne check_diag
	jmp .end

.next5:
	lda theBoard+0
	cmp x
	bne .end
	lda theBoard+4			; Check first diagonal
	cmp x
	bne .end				
	lda theBoard+8
	cmp x
	bne .end
	jmp .end

check_diag:
	lda theBoard+2
	cmp x
	beq .end			
	lda theBoard+4
	cmp x			
	beq .end			
	lda theBoard+6
	cmp x			
	bne .end
end:
	rts
