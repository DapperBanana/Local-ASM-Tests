
; Define some constants
.text    = $0200
.buffer  = $0300
.key     = 3

; Encrypt function
encrypt:
  lda #0
  sta $01
loop:
  lda .text, x
  beq done
  sta .buffer, x
  clc
  adc key
  sta .buffer, x
  inx
  bne loop
done:
  rts

; Decrypt function
decrypt:
  lda #0
  sta $01
loop:
  lda .buffer, x
  beq done
  sta .text, x
  sec
  sbc key
  sta .text, x
  inx
  bne loop
done:
  rts

; Main program
start:
  ldx #0
read:
  lda .text, x
  beq end
  jsr encrypt
  jsr decrypt
  jsr $ff00
  lda #<.buffer
  sta .text
  lda #>.buffer
  sta .text+1
  jsr $ffc5
  inx
  bne read
end:
  rts
