
ORG $0200

; Load the number of sides of the hendecagon (11)
LDA #11
STA sides

; Load the length of one side of the hendecagon (#20 for example)
LDA #<$20
STA side_low
LDA #>$20
STA side_high

; Calculate the apothem of the hendecagon
LDA #1
CLC
ADC #sides
ASL A
ADC #sides
TAX

LDA #2
CLC
ADC #side_low
STA side_low

LDA #0
ADC #side_high
STA side_high

; Calculate the area of the hendecagon
LDA #0
LDX #0

.area_loop
  CLC
  ADC side_low
  STA temp_low
  LDA #0
  ADC side_high
  STA temp_high

  LDX #0
  .sum_loop
    LDA temp_high
    ADC temp_low
    STA temp_low
    INC temp_high
    DEX
    BNE .sum_loop
  
  LDX #0
  .shift_loop
    LSR temp_low
    ROR temp_high
    DEX
    BNE .shift_loop

  LDA temp_low
  STA result

.dec_loop
  SBC sides
  TAX
  BCC .area_loop

; Store the result in memory location $0300
STA $0300

END
