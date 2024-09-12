
; Check if a given string is a valid IPv6 address

.include "emu6502.asm"
.org $0200

START:
	lda #0          ; Initialize index to 0
	sta index
	
loop:
	lda input, x    ; Load character at current index
	beq end         ; If character is null, end loop
	
	and #$ff
	cmp #$30        ; Check if character is within valid ASCII range (0-9)
	bcc invalid
	
	cmp #$39
	bcs check_lower_hex_chars
	
	cmp #$41        ; Check if character is within valid ASCII range (A-F or a-f)
	bcc invalid
	
	cmp #$46
	bcs invalid
	
check_lower_hex_chars:
	cmp #$61
	bcc invalid
	
	cmp #$66
	bcs invalid
	
check_colon:
	cmp #$3A        ; Check if character is a colon
	beq increment_index
	
invalid:
	lda #0          ; Set result to false
	jmp end
	
increment_index:
	inc index       ; Increment index
	lda index
	cmp #39         ; Check if reached end of string
	beq valid_ip
	
	lda input, x    ; Load character at current index
	beq end
	
	cmp #$3A        ; Check if character is a colon
	beq invalid     ; If colons are not at valid position, return invalid
	
	jmp loop

valid_ip:
	lda #1          ; Set result to true
end:
	
	sta result
	rts

input:
	.asciiz "2001:0db8:85a3:0000:0000:8a2e:0370:7334\0"
	
index:
	.byte $00
	
result:
	.byte $00
