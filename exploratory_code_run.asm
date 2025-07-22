
        ORG     $1000           ; start address

START   LDX     #$00            ; initialize sum to 0
        STX     SUM
        LDA     #123            ; load the number to be processed
        STA     NUMBER

LOOP    LDA     NUMBER          ; load the current number
        BEQ     DONE            ; if number is 0, we are done
        CLC                     ; clear carry flag
        ADC     #$30            ; convert ASCII digit to binary
        STA     TEMP            ; store the converted digit
        LDA     SUM             ; add current sum to the digit
        CLC
        ADC     TEMP
        STA     SUM             ; store the updated sum
        LDA     TEMP            ; check if sum is single digits
        CMP     #10
        BCC     NEXT            ; if less than 10, move to next digit
        SEC
        SBC     #10             ; subtract 10 to extract last digit
        STA     TEMP
        LDA     SUM             ; add last digit to sum
        CLC
        ADC     TEMP
        STA     SUM             ; update sum

NEXT    LSR     NUMBER          ; shift number right to get next digit
        LDA     NUMBER
        AND     #$0F
        BNE     LOOP            ; if more digits, repeat loop

DONE    LDA     SUM             ; final single-digit sum in accumulator

        ; add code here to use the result in the accumulator

        RTS                     ; return from subroutine

NUMBER  .BYTE   0
SUM     .BYTE   0
TEMP    .BYTE   0

        END     START           ; end of program
