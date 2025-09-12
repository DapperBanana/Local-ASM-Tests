
          ; Input: Radius in location $00-$01, Height in location $02-$03
          ; Output: Volume in location $04-$05
           .text
           .org $0600
start:     LDA $00          ; Load radius into accumulator
           STA $04          ; Store radius in output location
           LDA $01
           STA $05
           LDA $02          ; Load height into accumulator
           STA $06          ; Store height in output location
           LDA $03
           STA $07
           LDX $04          ; Load radius into X register
           LDY $06          ; Load height into Y register
           JSR calculate_volume ; Call the subroutine to calculate volume
           
           ; Print the results
           LDX $04
           LDY $05
           JSR print_result
           
           RTS

calculate_volume: 
           ; Volume = (1/3) * pi * radius^2 * height
           LDA #$03         ; Load 1/3 into accumulator
           STA $08
           LDA #$48         ; Load pi approximation (3.14) into accumulator
           STA $09
           LDY $07         ; Load height into Y register
           LDX $04         ; Load radius into X register
           JSR multiply    ; Multiply height by radius
           STA $0A         ; Store the result in $0A-$0B
           LDA $0A
           LDX $04         ; Load radius into X register
           LDY $04
           JSR multiply    ; Multiply radius by radius
           STA $0C         ; Store the result in $0C-$0D
           LDA $0C
           LDX $09         ; Load pi (3.14) into X register
           JSR multiply    ; Multiply pi by radius^2
           STA $0E         ; Store the result in $0E-$0F
           LDA $08
           LDX $0E         ; Load 1/3 * pi * radius^2 into X register
           JSR multiply    ; Multiply by 1/3
           STA $04         ; Store the result in $04-$05
           LDA $0F
           STA $05
           RTS

multiply:   ; Multiply Y by X and store the result in A
           PHA
           LDA #$00
loop:      CLC
           ADC $0F
           DEY
           BNE loop
           PLA
           RTS

print_result: 
           ; Print the volume in $04-$05
           LDA $04
           JSR print_byte
           LDA $05
           JSR print_byte
           RTS

print_byte:
           ; Print a single byte in the accumulator
           STA $0D
           LDA #$0A
           JSR $FFD2  ; Print character
           LDA $0D
           AND #$0F
           ORA #$30
           JSR $FFD2  ; Print character
           RTS
           
           .end
