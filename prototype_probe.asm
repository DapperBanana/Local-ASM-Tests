
; Input:
; R0 - Length of side of the regular hexadecagon

; Output:
; R0 - Area of the regular hexadecagon

        LDX #16          ; Load number of sides
        LDA #0           ; Initialize sum of areas
loop    STA temp         ; Store current value of sum of areas
        LDA R0           ; Get length of side
        SEC
        ADC temp         ; Add to sum of areas
        TAX
        JSR multiply     ; Multiply side length by current sum
        LDA product_low  ; Get low byte of product
        STA temp         ; Save low byte as new sum
        LDA product_high ; Get high byte of product
        ADC $00           ; Add high byte to sum
        STA temp + 1      ; Save sum
        DEX              ; Decrement sides counter
        BNE loop         ; If sides left, repeat loop

        LDA temp + 1     ; Get high byte of sum
        STA R0           ; Store as area of hexadecagon

done    RTS              ; Return from subroutine

multiply
        LDA 00           ; Get low byte of side length
        LDY #0
        CLC
        ADC #$00         ; Multiply current sum by side length
        STA temp_low
        LDA 01           ; Get high byte of side length
        ADC #$00
        STA temp_high

        LDA #0
        LDX #0
        LDA temp_high
        CLC
        ADC temp_low
        STA product_low  ; Store low byte of product
        LDA temp_high
        ADC #0
        STA product_high ; Store high byte of product

        RTS              ; Return from subroutine

temp    .DSW 2           ; Temporarily store sum of areas
product_low .DSB 1       ; Temporarily store low byte of product
product_high .DSB 1      ; Temporarily store high byte of product
temp_low .DSB 1          ; Temporarily store low byte of temp value
temp_high .DSB 1         ; Temporarily store high byte of temp value
