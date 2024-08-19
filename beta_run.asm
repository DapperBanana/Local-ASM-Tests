
        .org $1000

start   lda year    ; Load the year to be checked
        cmp #0      ; Check if the year is divisble by 4
        bne not_leap_year
        lda year    ; Load the year again
        cmp #100    ; Check if the year is divisble by 100
        beq check_century
        jmp is_leap_year

check_century
        lda year    ; Load the year again
        cmp #400    ; Check if the year is divisible by 400
        beq is_leap_year

not_leap_year
        lda #0      ; Load 0 to indicate not a leap year
        sta result
        jmp end

is_leap_year
        lda #1      ; Load 1 to indicate leap year
        sta result

end     rts

result  .byte 0
year    .byte 2020   ; Year to be checked

        .end
