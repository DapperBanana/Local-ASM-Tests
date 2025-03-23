
.ORG $0200

    LDX #$00            ; Initialize workout data index
    LDA #$00            ; Initialize total distance run
    STA $FE             ; Initialize total pushups
    STA $FF             ; Initialize total sit-ups
    
inputLoop:
    ; Prompt user to input workout data
    ldx #$00
    lda #$00
    jsr INPUT_NUMBER    ; Input distance run
    sta $0200,x
    clc
    adc $FE
    sta $FE
    
    ldy #$00
    lda #$01
    jsr INPUT_NUMBER    ; Input pushups
    sta $0201,x
    clc
    adc $FF
    sta $FF
    
    ldy #$00
    lda #$02
    jsr INPUT_NUMBER    ; Input sit-ups
    sta $0202,x
    
    ; Ask user if they want to input more data
    lda #$05
    jsr PRINT_STRING
    jsr INPUT_CHAR
    cmp #$59            ; 'Y' in ASCII
    bne displayProgress
    
    inx
    inx
    inx
    cmp #$10            ; Maximum of 16 entries
    bne inputLoop
    
displayProgress:
    ; Display total workout data
    lda #0
    jsr PRINT_STRING
    ldx #$00
    ldy #$03
displayLoop:
    lda $0200,x
    jsr PRINT_NUMBER
    lda $0201,x
    jsr PRINT_NUMBER
    lda $0202,x
    jsr PRINT_NUMBER
    
    lda #0
    jsr PRINT_STRING
    
    inx
    inx
    inx
    ldy #$0A
    
    dex
    bpl displayLoop
    
    ; End of program
    RTS

INPUT_NUMBER:
    jsr PRINT_STRING
    lda #$00
inputLoop2:
    jsr INPUT_CHAR
    cmp #$0D     ; Enter key in ASCII
    beq returnNumber
    sec
    sbc #$30
    tax
    lda #$0A
    clc
    adc A
    sta A
    inc $0200,x
    jmp inputLoop2

returnNumber:
    rts

INPUT_CHAR:
    jsr INPUT_CHAR
    rts

PRINT_STRING:
    rts

PRINT_NUMBER:
    rts

; Entry point
    JMP inputLoop

.END
