
SECBASE = $0200
PENTAGON_SIDE = $5

        ORG    $0200

        LDA    #PENTAGON_SIDE       ; Load the length of one side of the pentagon into the accumulator
        STA    SECBASE          ; Store the length of one side in memory location SECBASE

        LDA    SECBASE           ; Load the length of one side back from memory
        ASL                      ; Multiply by 2 to get the perimeter of the pentagon
        TAX                      ; Store the result in X register
        ASL
        TAX

        LDA    SECBASE           ; Load the length of one side back from memory
        JSR    MULT               ; Call the subroutine to multiply it by itself
        STA    SECBASE           ; Store the result in memory location SECBASE

        LDA    SECBASE           ; Load the result of squaring the side length back from memory
        ASL                      ; Multiply by 2 to get the product of the side length and the apothem
        TAX                      ; Store the result in X register
        ASL
        TAX

        LDA    SECBASE           ; Load the product of the side length and the apothem back from memory
        JSR    MULT               ; Call the subroutine to multiply it by the height of the prism
        TAX                      ; Store the final result in X register

        LDA    X
        STA    $0300             ; Store the final result in memory location $0300

        RTS

MULT    LDX    #$00               ; Initialize result in X register
        LDY    #$00               ; Initialize counter in Y register

MULT_LOOP
        CLC                      ; Clear carry flag
        LDA    SECBASE           ; Load the number to be multiplied in the accumulator
        ADC    X                 ; Add the result to the accumulator
        STA    X                 ; Store the result in memory
        LDA    X                 ; Load the result back from memory
        CMP    #255               ; Compare to check for overflow
        BCC    MULT_SKIP          ; Skip if no overflow
        INX                      ; Increment X register for overflow handling
        DEY                      ; Decrement counter
MULT_SKIP
        DEY                      ; Decrement the counter
        CPY    SECBASE           ; Compare counter with the number to be multiplied
        BNE    MULT_LOOP          ; Loop until all repetitions are done
        RTS

        END
