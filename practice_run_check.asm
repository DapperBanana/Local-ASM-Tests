
    .text
    lda #0
    sta count1
    sta count2
    lda #<input
    sta base1
    lda #>input
    sta base2
    ldx #<input
    ldy #>input
loop:
    ldy base2
    lda (base1), y
    cmp #0
    beq end
    cmp #" "  
    beq spaceEnd
    cmp #","
    beq spaceEnd
    cmp #"."
    beq spaceEnd
    cmp #"!"
    beq spaceEnd
    cmp #"?"
    beq spaceEnd
    cmp #"("
    beq spaceEnd
    cmp #")"
    beq spaceEnd
    space:
    iny
    bne loop
    spaceEnd:
    pha
    lda count1
    inx
    sta (stack, x)
    lda count2
    dex
    sta (stack, x)
    pla
    ina
    sta count1
    cmp #" "
    bne space
    cmp #","
    bne space
    cmp #"."
    bne space
    cmp #"!"
    bne space
    cmp #"?"
    bne space
    cmp #"("
    bne space
    cmp #")"
    bne space
    jmp loop
end:
    lda 0
stack: .res 16
count1: .res 1
count2: .res 1
base1: .res 2
base2: .res 2
input: .asciiz "hello world hello world goodbye"
