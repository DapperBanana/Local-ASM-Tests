
        .org $1000   ; start of first list
list1:  .byte $01,$02,$03,$04,$05,$06,$07,$08,$09,$0A

        .org $2000   ; start of second list
list2:  .byte $0A,$09,$08,$07,$06,$05,$04,$03,$02,$01

result: .byte $00     ; variable to store the result

        LDA #10      ; load loop counter
        STA $FF      ; store loop counter in $FF register

calc_sum1:
        LDA #$00     ; initialize sum1
        STA $01      ; clear accumulator

loop1:
        LDA list1,X  ; load number from list1
        CLC
        ADC $01      ; add number to sum1
        STA $01      ; store sum1 back
        INX          ; increment index
        DEX          ; decrease loop counter
        BNE loop1    ; branch if not done

calc_sum2:
        LDA #$00     ; initialize sum2
        STA $02      ; clear accumulator

loop2:
        LDA list2,X  ; load number from list2
        CLC
        ADC $02      ; add number to sum2
        STA $02      ; store sum2 back
        INX          ; increment index
        DEX          ; decrease loop counter
        BNE loop2    ; branch if not done

calc_mean1:
        LDA $01      ; load sum1
        CLC
        ADC #0       ; add zero
        SEC
        SBC $FF      ; divide by 10
        STA $01      ; store mean1

calc_mean2:
        LDA $02      ; load sum2
        CLC
        ADC #0       ; add zero
        SEC
        SBC $FF      ; divide by 10
        STA $02      ; store mean2

calc_corr_coeff:
        LDA #$00     ; initialize numerator
        STA $03      ; clear accumulator

        LDX #$00     ; initialize index

loop3:
        LDA list1,X  ; load number from list1
        SEC
        SBC $01      ; subtract mean1
        STA $04      ; store in temp variable

        LDA list2,X  ; load number from list2
        SEC
        SBC $02      ; subtract mean2
        STA $05      ; store in temp variable

        CLC
        ADC $03      ; add to numerator
        STA $03      ; store back

        SEC
        SBC $04      ; calculate part of denominator
        STA $06      ; store in temp variable

        SEC
        SBC $05      ; calculate part of denominator
        STA $07      ; store in temp variable

        INX          ; increment index
        DEX          ; decrease loop counter
        BNE loop3    ; branch if not done

        LDX $FF      ; load loop counter
        CLC
        ADC #1       ; add one more loop counter
        STA $FF      ; store back

        LDA $03      ; load numerator
        SEC
        SBC #$00     ; subtract zero
        STA $03      ; store back

        LDA $06      ; load part of denominator
        CLC
        ADC #$00     ; add zero
        SEC
        SBC $03
        LDA $06
        SEC
        SBC $06
        STA $08      ; store intermediate result

        LDA $07      ; load part of denominator
        CLC
        ADC #$00     ; add zero
        SEC
        SBC $03
        LDA $07      
        SEC
        SBC $07
        STA $09      ; store intermediate result

        LDA $08      ; load intermediate result
        CLC
        ADC $09      ; add result
        STA $08      ; store back

        LDA $08
        SEC
        SBC #$00
        STA $08

        LDA $08
        SEC
        SBC #$00
        STA $08

        LDA $08
        CLC
        ADC #1
        FRA $08
        STA result

        BRK
