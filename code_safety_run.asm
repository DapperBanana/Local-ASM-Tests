
; Volume of a Cylinder Calculator

; Define memory locations for variables
radius     .equ $00
height     .equ $01
volume     .equ $02

          .org $8000         ; Program start address

          lda #5            ; Load radius value (can be changed to any desired value)
          sta radius

          lda #10           ; Load height value (can be changed to any desired value)
          sta height

          lda radius        ; Load radius into A register
          sta $03           ; Store radius at memory location $03

          lda height        ; Load height into A register
          sta $04           ; Store height at memory location $04

          jsr calculateVolume  ; Call subroutine to calculate volume

          lda volume        ; Load the calculated volume from memory location $02 into A register

          ; Display result or perform further operations with the volume value

          ; End of program

calculateVolume:
          lda $03           ; Load radius from memory
          ldx $04           ; Load height from memory

          ; Calculate volume of the cylinder: volume = PI * radius^2 * height
          ; PI = 3.14, volume will be in units cubed

          sta $05           ; Copy radius to location $05
          lda $05           ; Load radius from location $05

          jsr multiply      ; Call subroutine to square the value in A register

          sta $06           ; Store the squared radius at location $06

          lda $06           ; Load squared radius back into A register
          ldx #3            ; Load constant PI with approximate value of 3.14
          jsr multiply      ; Multiply squared radius by PI

          sta $07           ; Store the final result in location $07 to be returned

          lda $07           ; Load the calculated volume into A register
          sta volume        ; Store the volume in memory location $02

          rts               ; Return from subroutine

multiply:
          ; Multiply A register by X register
          pha               ; Push A register to stack
          lda #0            ; Initialize product to 0

          loop:
          clc               ; Clear carry flag
          adc $00           ; Add A register to product
          tax               ; Transfer the result to X register
          lda $01           ; Load second number
          bne loop          ; Repeat until second number is 0

          pla               ; Pull A register from stack and store it back in A register
          rts               ; Return from subroutine

          .end               ; End of program
