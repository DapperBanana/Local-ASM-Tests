
; Convert Decimal Number to Fraction

          .org $0200

Start     lda #64           ; Load the decimal number to convert (in this case 64)
          sta num

          jsr ConvertToFraction  ; Call the subroutine to convert the decimal number to a fraction

          lda numerator        ; Load the numerator of the fraction
          sta $FD              ; Store the numerator in memory location $FD
          
          lda denominator      ; Load the denominator of the fraction
          sta $FE              ; Store the denominator in memory location $FE

          rts

ConvertToFraction:
          lda num              ; Load the decimal number
          ldx #$0D             ; Initialize the divisor
          ldy #0               ; Initialize the numerator
Loop:
          cpx #0               ; Check if the divisor is zero
          beq Done             ; If divisor is zero, exit the loop

          dex                  ; Decrement the divisor
          asl                  ; Shift the numerator left
          bcs Skip             ; If carry is set, skip adding divisor to numerator
          iny                  ; Increment the numerator
Skip:
          cmp #10              ; Compare the dividend with 10
          bcc Loop             ; If dividend is less than 10, continue looping
          sub #10              ; Subtract 10 from the dividend
          jmp Loop

Done:
          sty numerator        ; Store the numerator
          stx denominator      ; Store the denominator
          rts

num:      .byte 0
numerator: .byte 0
denominator: .byte 0

          .end
