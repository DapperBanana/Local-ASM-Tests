
; Program to convert a binary number to decimal number
;
; Input:
;     Binary number stored in memory location $4000-$4007 (8 bits) in little-endian format
; Output:
;     Decimal number in accumulator
;
; Algorithm:
;     1. Load the binary number into the accumulator
;     2. Initialize the decimal result to 0
;     3. Loop 8 times:
;        - Rotate the binary number left
;        - If carry flag is set, increment the decimal result by 1
;     4. Return the decimal result in the accumulator

; Start of program
        ORG $1000
START:
        LDA $4000      ; Load binary number into accumulator
        LDX #$08       ; Initialize loop counter
        LDA #$00       ; Initialize decimal result

CONVERT_LOOP:
        ROL            ; Rotate binary number left
        BCC SKIP_INC   ; Skip increment if carry flag is not set
        CLC            ; Clear carry flag
        ADC #$01       ; Increment decimal result

SKIP_INC:
        DEX            ; Decrement loop counter
        BNE CONVERT_LOOP ; Repeat loop if not done
        STA $4008      ; Store decimal result in memory
        BRK            ; End program

        ORG $4000
        .BYTE %10101010  ; Example binary number
        
        ORG $4008
        .BYTE $00       ; Placeholder for decimal result
        
        END START
