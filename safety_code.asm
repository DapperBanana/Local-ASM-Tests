
NUM    .BYTE   53  ; The number to be checked

START  LDA     #$02
       STA     BASE    ; Start with base = 2

       LDX     #NUM    ; Load the number into X

CHECK  LDA     BASE    ; Load base into A
       JSR     POWER   ; Calculate (BASE^NUM) mod NUM
       CMP     #$01
       BNE     NOT_CARMICHAEL

       INX             ; Increment base
       CPX     #$FF    ; Base = 255
       BNE     CHECK

       LDA     #$01    ; Number is a Carmichael number
       BRK

NOT_CARMICHAEL:
       LDA     #$00    ; Number is not a Carmichael number
       BRK

POWER  SEC
       LDA     #$01
       STA     EXPONENT

POWER_LOOP:
       LDY     #NUM
       DEY
       BEQ     POWER_END

       LDA     BASE
       STA     TEMP
       CLC
       ADC     TEMP
       BCC     ADD_DONE

       LDA     #$00
       STA     CARRY

ADD_DONE:
       STA     TEMP
       TYA
       DEY
       BMI     NEGATIVE_EXPONENT

EXPONENT_LOOP:
       LDA     TEMP
       ADC     BASE
       STA     TEMP
       DEY
       BNE     EXPONENT_LOOP

NEGATIVE_EXPONENT:
       TSX
       TXA
       STA     EXPONENT
       TAX
       RTS

POWER_END:
       LDA     LOW(EXPONENT)
       SEC
       SBC     #$01

       RTS

BASE    .BYTE   0
EXPONENT .BYTE   0
TEMP    .BYTE   0
CARRY   .BYTE   0

       .ORG    $FFFA
       .WORD   START
