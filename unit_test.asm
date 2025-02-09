
.INCLUDE "vcs.h"

RESET_VECTOR	= $FCE2
BAUD_RATE      = $FCD2
OPEN           = $FF0C
CLOSE          = $FF0F
JUMP_TABLE     = $FF38		; table of jump addresses
JMP_INTO_BASIC = $FCE1
JMP_TO_OS     = $FFF3
PUT_CFG       = $FFB7
SETLFS        = $FFBA
SETNAM        = $FFBD
LOAD          = $FFC0

*=$0801
	*=$0801
	.data
	.byte $0b, $08, $0a, $00, $9e, $20, $32, $30, $31, $00, $00, $00  ; 08 0a 00 is 90000
	.byte $00, $98, $48, $ff, $d2, $fc, $a9, $01, $8d, $00, $04, $48  ; set initial values in memory for BASIC
	.byte $a9, $00, $85, $06, $85, $07, $20, $d4, $bc, $4c, $f3, $fc  ; entry point to assembler program

	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $04, $00, $00, $00, $00  ; machine language program, press return after 3 seconds
	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	
.start
	lda #$0		;clear A register
	sta $01		;clear low byte
	sta $02		;clear high byte
	
wait_key_press
	lda $02		;check high byte
	bne wait_key_press	;if high byte is not zero then wait 
	
	lda $01		;check low byte
	beq wait_key_press	;if low byte is not zero then wait 
	
.routine
	ldy #0	;initialize Y to 0
	
get_input
	lda $01		;get input from low byte
	beq asl_input	;if low byte is 0 then add the input from high byte
	
add_input
	clc
	adc $02		;calculate sum of numbers
	adc #$00
	sta $02	;store result in high byte
	adc #$FF
	sta $02	
	lda #$00
	add_input2
	inc $01	;increment low byte
asl_input
	lda $02	;shift multi byte variable
	rol $02
	rol $01
	bcc add_input2
	
	iny
	lda $01
	bne get_input
	
	ldy #2	;store result in 9000-9002
	sty $d016
	stx $d017
	sta $d018
	
	rts	;return from subroutine
