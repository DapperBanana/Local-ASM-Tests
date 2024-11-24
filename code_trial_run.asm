
 ; Program to calculate the area of a pentagon

 .org $0200             ; Start at address $0200

 pentagon_side  .byte 10 ; Define the side length of the pentagon

 ; Initialize variables
 pentagon_area .byte 0  ; Variable to store the area of the pentagon
 pentagon_apothem .byte 0 ; Variable to store the apothem of the pentagon

 ; Main program
 start
     lda pentagon_side   ; Load the side length of the pentagon
     jsr calc_apothem    ; Jump to subroutine to calculate apothem
     jsr calc_area       ; Jump to subroutine to calculate area
     hlt                 ; Halt the program

 ; Subroutine to calculate apothem of the pentagon
 calc_apothem
     lda pentagon_side   ; Load the side length of the pentagon
     lsr                 ; Divide by 2
     sta pentagon_apothem ; Store the apothem
     rts                 ; Return from subroutine

 ; Subroutine to calculate the area of the pentagon
 calc_area
     lda pentagon_side   ; Load the side length of the pentagon
     lda pentagon_apothem ; Load the apothem
     sei                 ; Disable interrupts
     mul                 ; Calculate area using multiplication
     sta pentagon_area   ; Store the area
     rts                 ; Return from subroutine
