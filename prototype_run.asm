
      .org $0200

start lda year   ; Load the year into the accumulator
      cmp #$00    ; Compare with 0
      beq not_leap_year  ; If year is 0, it is not a leap year

      cmp #$01    ; Compare with 1
      beq leap_year ; If year is 1, it is a leap year

      ldx #$00
      ldy #$04

loop  lda year   ; Load the year into the accumulator
      clc
      adc #$07    ; Add 7 to the year
      sta year    ; Store the updated year back
      dey
      bne loop

      lda year   ; Load the year into the accumulator
      cmp #$00    ; Compare with 0
      bne not_leap_year  ; If year is not divisible by 4, it is not a leap year

      lda year   ; Load the year into the accumulator
      cmp #$64    ; Compare with 100
      beq not_leap_year  ; If year is divisible by 100 but not by 400, it is not a leap year

leap_year
      lda #$01    ; Set the result to 1 (leap year)
      sta result

not_leap_year
      lda #$00    ; Set the result to 0 (not a leap year)
      sta result

end   lda result  ; Load the result into the accumulator
      sta $0201   ; Store the result at memory location $0201
      rts         ; Return from subroutine

      .org $02FF
year  .byte $bc   ; Year to be checked
result .byte $00  ; Result variable to store if the year is a leap year
