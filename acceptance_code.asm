
LDA #4      ; base of the parallelogram
STA Base    ; store base in memory
LDA #5      ; height of the parallelogram
STA Height  ; store height in memory

LDA Base    ; load base
ADC Height  ; add height
TAX         ; transfer result to X register

LDA Base    ; load base
STA $00     ; save base in memory
LDA Height  ; load height
STA $01     ; save height in memory

JSR Multiply ; call subroutine to multiply values in $00 and $01
          ; result stored in $02 and $03

LDA $02     ; load result
STA Area    ; store result in memory

HLT         ; halt program

Multiply:
  LDX $00     ; load value in $00 to X register
  LDA #$00    ; clear A register for multiplication
  CLC         ; clear carry
  LDA $01     ; load value in $01 to A register
  JSR MultiplyLoop ; call subroutine to perform multiplication
  RTS         ; return from subroutine

MultiplyLoop:
  LDA #$00    ; clear A register for addition
  ADC X       ; add X register value to A register
  DEX         ; decrement X register
  CPX #$00    ; check if X register is 0
  BNE MultiplyLoop ; if not 0, continue loop
  STA $02     ; store result in $02
  RTS         ; return from subroutine

Base:   .BYTE 0
Height: .BYTE 0
Area:   .BYTE 0
