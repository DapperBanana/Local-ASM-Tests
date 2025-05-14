
; Generate a random alphanumeric password

	org $1000

start:
	sei
	lda #$ff
	sta $d011
	sta $d012
	lda #%00011000
	sta $dd0f 	;PRNG mode no interlace
	lda #%00001110
	sta $dd00	;PRNG mode

loop:
	lda $dd00	; Read PRNG value
	and #%00011111	; Mask out upper 3 bits to get a number between 0-31

	; Convert number to ASCII character
	cmp #$0a
	bcc num
	adc #$07
num:
	adc #$30	; Convert number to ASCII digit
	cmp #$3a
	bcc store
	adc #$07
store:
	sta $fb00	; Store character in password buffer
	inc $fbff	; Increment buffer pointer
	lda $fbff
	cmp #$0a	; Check if password is 10 characters long
	bne loop

	; Print password
	sei
	lda #$ff
	sta $d011
	lda #$18	; Set screen mode to uppercase text
	sta $d016
	ldx #$00
	ldy #$0a
print_loop:
	lda $fb00, x
	cmp #$00
	beq done
	sta $0400, y
	inx
	dey
	bne print_loop
done:
	cli
rts

