
; Virtual Pet program in 6502 Assembly language
; The pet's status is displayed on the screen

.pet_hunger    = $00
.pet_happiness = $01
.pet_tiredness = $02

NMI:
    lda #0
    sta $2003   ; Set VRAM address to $2000 (top left corner)
    
    ldx .pet_hunger
    jsr print_value
    
    lda #","
    jsr print_char
    
    ldx .pet_happiness
    jsr print_value
    
    lda #","
    jsr print_char
    
    ldx .pet_tiredness
    jsr print_value
    
    rti

print_char:
    sta $2007   ; Write character to VRAM
    rts

print_value:
    txa
    clc
    adc #$30    ; Convert value to ASCII
    jsr print_char
    rts

.pet_update:
    inc .pet_hunger
    dec .pet_happiness
    inc .pet_tiredness
    rts

.main:
    jsr .pet_update
    
    nmi
    
    jmp .main

    .org $FFFA
    .word NMI
