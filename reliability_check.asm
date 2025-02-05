
        .org $c000

load_file:
        lda #$01        ; Open file for reading
        sta $ff00

        ldx #$01        ; Filehandle 1 
        ldy #$00        ; Drive 0, file 0
        jsr $ff3b       ; Turn on printing and parsing           
        lda $ff00       ; Load file status
        and #$1f       
        bne error
        
read_loop:
        lda $ff00       ; Load file status
        and #$1d        ; Check for EOF
        beq done

        lda $ff00
        jsr $ff09       ; Read character
        cmp #','
        bne skip
        lda #$00
        sta $ff02       ; Convert to integer
        ldy #$00
        lda $ff02        
        clc
        adc sum
        sta sum
        lda #$00
        sta $ff00       ; Reset file register after read
        jmp read_loop

skip:
        lda $ff02
        sta $ff02       ; Increment pointer
        lda #$00
        sta $ff00       ; Reset file register after read
        jmp read_loop

error:
        lda $ff00       ; Load file status
        jsr $ff34       ; Print error message

done:
        lda sum
        jsr $ff16       ; Print the sum

        lda #$00
        sta $ff00       ; Close the file
        rts

sum: 
        .byte $00, $00   ; Initialize sum variable

        .end
