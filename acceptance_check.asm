
START LDA $00     ; Load x-coordinate of point 1
      STA $08     ; Store x-coordinate in $08
      
      LDA $01     ; Load y-coordinate of point 1
      STA $09     ; Store y-coordinate in $09
      
      LDA $02     ; Load z-coordinate of point 1
      STA $0A     ; Store z-coordinate in $0A
      
      LDA $03     ; Load x-coordinate of point 2
      STA $0B     ; Store x-coordinate in $0B
      
      LDA $04     ; Load y-coordinate of point 2
      STA $0C     ; Store y-coordinate in $0C
      
      LDA $05     ; Load z-coordinate of point 2
      STA $0D     ; Store z-coordinate in $0D

      ; Calculate distance between the two points using the distance formula
      LDA $08     ; Load x-coordinate of point 1
      SEC          ; Set carry flag
      SBC $0B     ; Subtract x-coordinate of point 2
      STA $10     ; Store the result in $10 (x_diff)
      
      LDA $09     ; Load y-coordinate of point 1
      SEC          ; Set carry flag
      SBC $0C     ; Subtract y-coordinate of point 2
      STA $11     ; Store the result in $11 (y_diff)
      
      LDA $0A     ; Load z-coordinate of point 1
      SEC          ; Set carry flag
      SBC $0D     ; Subtract z-coordinate of point 2
      STA $12     ; Store the result in $12 (z_diff)
      
      ; Calculate the square of the distance
      LDA $10     ; Load x_diff
      ASL          ; Multiply by 2
      STA $13     ; Store the result in $13
      
      LDA $11     ; Load y_diff
      ASL          ; Multiply by 2
      STA $14     ; Store the result in $14
      
      LDA $12     ; Load z_diff
      ASL          ; Multiply by 2
      STA $15     ; Store the result in $15

      CLC          ; Clear carry flag
      LDA $13     ; Load x_diff squared
      ADC $14     ; Add y_diff squared
      ADC $15     ; Add z_diff squared
      
      ; Take the square root to get the final distance
      STA $06     ; Store the result in $06

DONE  BRK          ; End of program

      .ORG $0200   ; Start address of program
      
      JMP START   ; Start the program
