
        .org $0200

start   LDA #0      ; Initialize accumulator
        STA sum

        LDX #0      ; Initialize index for digit counter

input   LDA $0300,X ; Load next digit from input number
        CLC
        ADC sum     ; Add current digit to sum
        STA sum

        INX         ; Increment index
        CPX #8      ; Check if last digit processed
        BNE input   ; If not, go back to input

        LDA sum     ; Load current sum

check   CMP #10     ; Check if sum is greater than 10
        BCC output  ; If not, go to output

        JSR split   ; If greater than 10, split into digits
        BRA calculate

split   LSR         ; Right shift to get tens digit
        LSR
        LSR
        LSR
        STA tens

        LDA sum     ; Mask to get ones digit
        AND #$0F
        STA ones

        RTS

calculate
        LDA tens
        CLC
        ADC ones    ; Add tens and ones digit
        STA sum

        JMP check   ; Continue checking until single-digit number

output  STA result  ; Store single-digit result

done    BRK         ; End program

result  .byte 0
sum     .byte 0
tens    .byte 0
ones    .byte 0

        .org $0320
inputNum .byte $12, $34, $56, $78, $9A, $BC, $DE, $F0

        .end
