
        .org $0200

start   lda #card1        ; Load first card into A register
        sta current_card ; Store current card
        jsr print_card   ; Print current card
        jsr get_input     ; Get player input
        jsr process_input ; Process player input

end     rts

current_card .byte 0        ; Holds the current card
input       .byte 0        ; Holds player input

card1       .byte "Card A"
card2       .byte "Card B"
card3       .byte "Card C"

print_card:
        lda current_card
        cmp #card1
        beq print_card1
        cmp #card2
        beq print_card2
        cmp #card3
        beq print_card3
        rts

print_card1:
        lda #<card1
        jsr print_string
        lda #>card1
        jsr print_string
        rts

print_card2:
        lda #<card2
        jsr print_string
        lda #>card2
        jsr print_string
        rts

print_card3:
        lda #<card3
        jsr print_string
        lda #>card3
        jsr print_string
        rts

get_input:
        lda #<input
        sta $FFFC   ; Setup for GETIN
        jsr $FFFE   ; Perform GETIN
        lda input
        rts

process_input:
        lda input
        cmp #"1"
        beq process_input1
        cmp #"2"
        beq process_input2
        cmp #"3"
        beq process_input3
        rts

process_input1:
        lda #card2
        sta current_card
        jsr print_card
        rts

process_input2:
        lda #card3
        sta current_card
        jsr print_card
        rts

process_input3:
        lda #card1
        sta current_card
        jsr print_card
        rts

print_string:
        lda #<BUFFER
        sta $0200    ; Store low byte of buffer address
        lda #>BUFFER
        sta $0201    ; Store high byte of buffer address
        jmp PRINT

PRBUFF  = $0200
PRLEN   = $0202
PRCMD   = $0203
        .org $FC00
PRINT   lda (PRLEN),y
        beq PRINT1
        jmp PRINT2
PRINT1  sec
        lda #<SIO
        sta 6,x
        lda #>SIO
        sta 7,x
        lda #$00
        sta 4,x
        lda PRBUFF,y
        sta $200
        lda PRBUFF+1,y
        sta $201
        lda #$03
        sta 5,x
        lda #$04
        sta 2,x
PRINT2  inc PRBUFF
        inc PRBUFF+1
        dec PRLEN
        beq PRINT3
        rts
PRINT3  clc
        lda #<CROUT
        sta 6,x
        lda #>CROUT
        sta 7,x
        lda #$03
        sta 5,x
        lda #$04
        sta 2,x
        rts

; Output routines
CROUT   .byte   'CR'

; Buffer for storing string
BUFFER  .res    256
        
SIO     .byte $FD    ; Serial Output
