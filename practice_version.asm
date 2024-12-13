
        .org $0200
start   lda #0         ; Initialize accumulator
        sta total
        ldx #0         ; Initialize index register
        ldy #0         ; Initialize index register
next    lda num,x     ; Load next character from input string
        beq done       ; Branch if end of string
        cmp #67        ; Check if character is 'C'
        beq checkC
        cmp #76        ; Check if character is 'L'
        beq checkL
        cmp #88        ; Check if character is 'X'
        beq checkX
        cmp #73        ; Check if character is 'I'
        beq checkI
done    lda total      ; Load result into accumulator
        rts

checkC  inx            ; Increment index
        lda num,x
        beq addC
        cmp #68        ; Check if next character is 'D'
        bne addC
        ldx #5          ; Add 400 to total
        lda total
        clc
        adc #400
        sta total
        jmp next

addC    lda total      ; Add 100 to total
        clc
        adc #100
        sta total
        jmp next

checkL  inx            ; Increment index
        lda num,x
        beq addL
        cmp #88        ; Check if next character is 'C'
        bne addL
        ldx #3          ; Add 90 to total
        lda total
        clc
        adc #90
        sta total
        jmp next

addL    lda total      ; Add 50 to total
        clc
        adc #50
        sta total
        jmp next

checkX  inx            ; Increment index
        lda num,x
        beq addX
        cmp #67        ; Check if next character is 'L'
        bne addX
        ldx #1          ; Add 40 to total
        lda total
        clc
        adc #40
        sta total
        jmp next

addX    lda total      ; Add 10 to total
        clc
        adc #10
        sta total
        jmp next

checkI  inx            ; Increment index
        lda num,x
        beq addI
        cmp #88        ; Check if next character is 'C'
        beq subI
        cmp #86        ; Check if next character is 'V'
        beq subI
        cmp #76        ; Check if next character is 'L'
        beq subI
        cmp #73        ; Check if next character is 'I'
        bne addI
        lda num,y
        cpx #16         ; Check if I is repeated three times
        beq subI
        cpx #17         ; Check if I is repeated four times
        beq subI
        cpx #18         ; Check if I is repeated five times
        bne addI
        iny             ; Increment index
        lda #73         ; Load ASCII 'I' into accumulator
        jsr mult        ; Multiply total by 2
        rts

addI    lda total      ; Add 1 to total
        clc
        adc #1
        sta total
        jmp next

subI    lda total      ; Subtract 1 from total
        sec
        sbc #1
        sta total
        jmp next

mult    asl total      ; Multiply by 2
        rts

total   .byte 0        ; Result
num     .byte "C"      ; Input Roman numeral
        .byte 0        ; Null terminator
