
        .org $0200

START   LDA #$00           ; Initialize sum to 0
        STA SUM

        LDA #$02           ; Start checking numbers from 2
LOOP    JSR IS_PRIME      ; Check if current number is prime
        BCC NOT_PRIME      ; Branch if not prime

        CLC               ; Add prime number to sum
        ADC CURRENT_NUM
        STA SUM

NOT_PRIME
        INC CURRENT_NUM    ; Move to the next number
        CMP LIMIT          ; Compare with the limit
        BCC LOOP           ; Branch if not reached the limit

DONE    HLT

SUM     .byte $00
CURRENT_NUM .byte $02
LIMIT   .byte $14

IS_PRIME
        LDX #$02           ; Initialize divisor to 2
CHECK   CPX CURRENT_NUM   ; Compare divisor with current number
        BEQ PRIME         ; Branch if divisor equals current number
        CPY #$02           ; Check if divisor is greater than 2
        BEQ DIVISIBLE      ; Branch if divisor equals 2
        CPY #$00           ; Check if current number is divisible by divisor
        BEQ NOT_PRIME      ; Branch if divisible

        DEX               ; Decrement divisor
        BNE CHECK         ; Branch to check if not zero

PRIME   RTS

DIVISIBLE
        SEC
        RTS

        .end
