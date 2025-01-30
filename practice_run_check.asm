
   .org $0600

PETNAME    .byte "PET"
HUNGER     .byte 100
HAPPINESS  .byte 100

   .org $0800

START:
   lda #<PETNAME
   sta $A0
   lda #>PETNAME
   sta $A1

LOOP:
   jsr SHOW_STATUS
   jsr WAIT_FOR_INPUT
   jsr UPDATE_STATUS
   jmp LOOP

SHOW_STATUS:
   ldx $A0
   lda (X),Y
   jsr $FFD2
   lda HUNGER
   jsr $FFD2
   lda HAPPINESS
   jsr $FFD2
   rts

WAIT_FOR_INPUT:
   jsr $FFCF
   rts

UPDATE_STATUS:
   lda HUNGER
   sec
   sbc #1
   sta HUNGER
   lda HAPPINESS
   sec
   sbc #1
   sta HAPPINESS
   rts
