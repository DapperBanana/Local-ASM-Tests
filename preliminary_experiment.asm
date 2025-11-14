
         .text
         .org  $0600
start:    ldx   #$01               ; Load the sides of the pentagon
          ldy   #$05
          jsr   area_pentagon      ; Call the subroutine to calculate area
          jsr   end_program        ; Call the subroutine to end the program
          brk

area_pentagon:
          lda   $00                ; Load the sides of the pentagon
          sta   $f0
          lda   $01
          sta   $f1

          lda   $f0                ; Multiply the sides to get the base
          clc
          adc   $f1
          sta   $f2

          asl   $f2                ; Multiply the base by 5 (number of sides)
          asl   $f2
          sta   $f2
          asl   $f2
          sta   $f2

          ldx   $f2
          rts

end_program:
          lda   #$00
          ldy   #$00
          rts
