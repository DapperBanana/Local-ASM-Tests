
NUM = $2000
FACTORS = $2002
TMP = $2004

    LDA NUM        ; Load the number to check into the accumulator
    JSR CHECK_VAMPIRE_NUMBER  ; Call the function to check if it's a vampire number
    BEQ NOT_VAMPIRE  ; If the result is zero, it's not a vampire number
    JMP IS_VAMPIRE  ; If the result is non-zero, it's a vampire number

CHECK_VAMPIRE_NUMBER:
    PHA        ; Save the original number on the stack
    STA TMP    ; Store the number in a temporary variable
    LDX #0     ; Initialize X to 0
    LDY #0     ; Initialize Y to 0

    ; Loop to find all possible combinations of factors
CHECK_FACTORS:
    INX        ; Increment X
    LDA TMP
    SEC
    SBC #$0A   ; Subtract 10 from the number
    STA TMP    ; Store the updated number
    BCC FACTOR_FOUND  ; If no carry is generated, proceed to check the factors
    JMP NOT_VAMPIRE  ; If a carry is generated, exit the loop as no factors found

FACTOR_FOUND:
    TYA
    CLC
    ADC #1     ; Increment Y
    STA TMP    ; Store the updated number
    CPY #10    ; Check if Y reached 10 (maximum number of digits)
    BNE CHECK_FACTORS  ; If not, continue checking for factors

    PLA        ; Restore the original number from the stack
    STA TMP    ; Store it in the temporary variable
    LDX #0     ; Reinitialize X to 0

    ; Loop to find matching factors
MATCH_FACTORS:
    INX        ; Increment X
    CPX #10    ; Check if X reached 10 (maximum number of digits)
    BEQ NOT_VAMPIRE  ; If no matching factors found, exit the loop

    LDA TMP
    STA FACTORS  ; Store the first factor
    LDA #0
    STA TMP    ; Reset the temporary variable

    LDX #0     ; Reinitialize X to 0

    LDA FACTORS  ; Load the first factor
    STA TMP

    ; Loop to find the second factor
FIND_SECOND_FACTOR:
    INX        ; Increment X
    LDA TMP
    SEC
    SBC #$0A   ; Subtract 10 from the first factor
    STA TMP    ; Store the updated factor
    BCC SECOND_FACTOR_FOUND  ; If no carry is generated, proceed to check the second factor
    JMP MATCH_FACTORS  ; If a carry is generated, continue to the next factor to test

SECOND_FACTOR_FOUND:
    TYA
    CPX #10    ; Check if X is equal to 10
    BEQ IS_VAMPIRE  ; If a matching factor is found, it's a vampire number

    LDA TMP
    PHA
    LDX #0     ; Reset X to 0
    STA TMP    ; Store the first factor in the temporary variable

    LDA #0
    STA FACTORS  ; Reset the factors

    ; Loop to find the second factor
FIND_SECOND_FACTOR2:
    INX        ; Increment X
    LDA TMP
    SEC
    SBC #$0A   ; Subtract 10 from the first factor
    STA TMP    ; Store the updated first factor
    BCC SECOND_FACTOR_FOUND2  ; If no carry is generated, proceed to check the second factor
    JMP NOT_VAMPIRE  ; If a carry is generated, exit the loop as no factors found

SECOND_FACTOR_FOUND2:
    PLA        ; Restore the first factor
    STA FACTORS  ; Store it as the second factor
    LDA FACTORS
    SEC
    SBC #$0A   ; Subtract 10 from the second factor
    BCS NOT_VAMPIRE  ; If a carry is generated, exit the loop as not a valid second factor

    CLC
    ADC #1     ; Account for the extra increment of X
    STA TMP

    JSR MULTIPLY_FACTORS  ; Call the function to multiply the factors
    LDA NUM
    CMP TMP    ; Compare the product with the original number
    RTS

MULTIPLY_FACTORS:
    LDA FACTORS
    CLC
    ADC TMP   ; Add the first factor to the product
    STA TMP
    RTS

NOT_VAMPIRE:
    LDA #0
    RTS

IS_VAMPIRE:
    LDA #1
    RTS
