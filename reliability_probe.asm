
    .org $0200

year    .byte $00

start   lda year
        cmp #$00        ; Check if year is divisible by 4
        beq leap_year

        lda year
        cmp #$05        ; Check if year is divisible by 100
        beq not_leap_year

        lda year
        and #$03        ; Check if year is divisible by 400
        beq leap_year

not_leap_year
        lda #$00
        sta $0200       ; Store 0 in memory as result
        rts

leap_year
        lda #$01
        sta $0200       ; Store 1 in memory as result
        rts
