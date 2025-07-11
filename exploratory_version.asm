
    .org $8000

start:
    ; Load the number whose factorial needs to be calculated
    lda #5
    sta num

    ; Initialize the accumulator to 1
    lda #$01
    sta result

    ; Call the recursive factorial function
    jsr factorial

    ; Display the result
    lda result
    sta $FB
    lda #$00
    sta $FA
    jsr $FFD2

    ; End program
    rts

factorial:
    ; Check if number is 0 or 1, return 1 in that case
    cmp #0
    beq base_case
    cmp #1
    beq base_case

    ; Calculate factorial recursively
    lda num
    dex
    sta num
    jsr factorial
    lda result
    clc
    adc num
    sta result

    rts

base_case:
    lda #$01
    rts

num: .byte 0
result: .byte 0

    .end
