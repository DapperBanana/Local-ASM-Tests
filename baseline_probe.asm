
        .org $0200

START   lda #<DATAFILE
        sta $FB
        lda #>DATAFILE
        sta $FC
        jsr OPEN            ; Open the CSV file
        jsr READ            ; Read the first row
        ldx #0              ; Initialize sum to 0
        ldy #0

LOOP    lda $FB           ; Load first value from the row
        clc
        adc $FC
        sta $FD
        lda $FB+1         ; Load second value from the row
        adc $FC+1
        sta $FE
        lda $FB+2         ; Load third value from the row
        adc $FC+2
        sta $FF
        
        iny               ; Move to the next row
        jsr READ
        
        cpy #3            ; Check if there are more rows
        bne LOOP
        
        lda $FD           ; Load the sum of first column values
        sta RESULT1
        lda $FE           ; Load the sum of second column values
        sta RESULT2
        lda $FF           ; Load the sum of third column values
        sta RESULT3
        
END     jmp END

OPEN    ldx #0            ; Set up file mode (read)
        lda #15
        jsr $FFD5          ; Open file
        rts

READ    ldx #0
        lda #$00
        jsr $FFD7          ; Read a line from the file
        rts

DATAFILE .byte "data.csv", 0

RESULT1 .byte 0
RESULT2 .byte 0
RESULT3 .byte 0

        .end
