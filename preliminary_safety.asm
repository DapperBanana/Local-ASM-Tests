
; Random Crossword Puzzle Generator

        .org $c000

puzzlegen:
        lda #$00
        sta $6000 ; start address for puzzle data
        lda #$00
        sta $6001 ; current puzzle position
        lda #$01
        sta $6002 ; puzzle size
        
genloop:
        lda #$00
        jsr rand ; generate a random number (0-255)
        and #$07 ; mask out lower 3 bits
        sta $6003 ; store random number
        
        lda $6001
        cmp $6002 ; check if puzzle is complete
        beq finish
        
        lda $6000
        sta $6004 ; current puzzle data
        
        lda $6003
        cmp #$04 ; check if current cell is filled
        beq nextcell
        
        sta $6004 ; fill current cell
        lda $6000
        clc
        adc #$01 ; move to next cell
        sta $6000
        
nextcell:
        lda $6001
        clc
        adc #$01 ; move to next position
        sta $6001
        
        jmp genloop
        
finish:
        rts

rand:
        lda $d20a
        asl
        rol $d20a
        ror $d20a
        sta $d20a
        rts
