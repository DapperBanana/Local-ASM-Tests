
        .org $0200

check_leap_year:
        ; Input: X - year

        lda X           ; Load the year into the accumulator
        cmp #$04        ; Check if the year is divisible by 4
        bne not_leap    ; If not divisible by 4, not a leap year
        lda X           ; Load the year into the accumulator
        cmp #$64        ; Check if the year is divisible by 100
        beq not_leap    ; If divisible by 100, not a leap year
        lda X           ; Load the year into the accumulator
        cmp #$64        ; Check if the year is divisible by 400
        bne not_leap    ; If not divisible by 400, not a leap year

        lda #$01        ; If all conditions are met, it is a leap year
        rts

not_leap:
        lda #$00        ; If any of the conditions are not met, it is not a leap year
        rts

        .end
