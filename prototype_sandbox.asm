
    .org $1000

    ; Define constants
    NAME_LENGTH = 20
    JOB_LENGTH = 20
    BUFFER_LENGTH = NAME_LENGTH + JOB_LENGTH + 3

    ; Define memory locations
    BUFFER = $0200
    NAME = $0300
    JOB = $0314

    START:
        ; Display instructions
        LDA #$00
        JSR PRINT_STRING
        LDA #'E'
        JSR PRINT_CHAR
        LDA #'n'
        JSR PRINT_CHAR
        LDA #'t'
        JSR PRINT_CHAR
        LDA #'e'
        JSR PRINT_CHAR
        LDA #'r'
        JSR PRINT_CHAR
        LDA #' '
        JSR PRINT_CHAR
        LDA #'y'
        JSR PRINT_CHAR
        LDA #'o'
        JSR PRINT_CHAR
        LDA #'u'
        JSR PRINT_CHAR
        LDA #'r'
        JSR PRINT_CHAR
        LDA #' '
        JSR PRINT_CHAR
        LDA #'n'
        JSR PRINT_CHAR
        LDA #'a'
        JSR PRINT_CHAR
        LDA #'m'
        JSR PRINT_CHAR
        LDA #'e'
        JSR PRINT_CHAR
        LDA #':'
        JSR PRINT_CHAR

        ; Read name
        LDA NAME
        STA BUFFER
        LDX #NAME_LENGTH
        JSR READ_STRING

        ; Set job buffer pointer
        LDX #JOB
        STX BUFFER

        ; Display job instructions
        LDA #'E'
        JSR PRINT_CHAR
        LDA #'n'
        JSR PRINT_CHAR
        LDA #'t'
        JSR PRINT_CHAR
        LDA #'e'
        JSR PRINT_CHAR
        LDA #'r'
        JSR PRINT_CHAR
        LDA #' '
        JSR PRINT_CHAR
        LDA #'j'
        JSR PRINT_CHAR
        LDA #'o'
        JSR PRINT_CHAR
        LDA #'b'
        JSR PRINT_CHAR
        LDA #' '
        JSR PRINT_CHAR
        LDA #'t'
        JSR PRINT_CHAR
        LDA #'i'
        JSR PRINT_CHAR
        LDA #'t'
        JSR PRINT_CHAR
        LDA #'l'
        JSR PRINT_CHAR
        LDA #'e'
        JSR PRINT_CHAR
        LDA #':'
        JSR PRINT_CHAR

        ; Read job title
        LDA JOB
        STA BUFFER
        LDX #JOB_LENGTH
        JSR READ_STRING

        ; Display confirmation message
        LDA #'T'
        JSR PRINT_CHAR
        LDA #'h'
        JSR PRINT_CHAR
        LDA #'a'
        JSR PRINT_CHAR
        LDA #'n'
        JSR PRINT_CHAR
        LDA #'k'
        JSR PRINT_CHAR
        LDA #' '
        JSR PRINT_CHAR
        LDA #'y'
        JSR PRINT_CHAR
        LDA #'o'
        JSR PRINT_CHAR
        LDA #'u'
        JSR PRINT_CHAR
        LDA #','
        JSR PRINT_CHAR
        LDA #' '
        JSR PRINT_CHAR
        LDA NAME
        JSR PRINT_STRING
        LDA #','
        JSR PRINT_CHAR
        LDA #' '
        JSR PRINT_CHAR
        LDA #'y'
        JSR PRINT_CHAR
        LDA #'o'
        JSR PRINT_CHAR
        LDA #'u'
        JSR PRINT_CHAR
        LDA #'r'
        JSR PRINT_CHAR
        LDA #' '
        JSR PRINT_CHAR
        LDA JOB
        JSR PRINT_STRING
        LDA #' '
        JSR PRINT_CHAR
        LDA #'a'
        JSR PRINT_CHAR
        LDA #'p'
        JSR PRINT_CHAR
        LDA #'p'
        JSR PRINT_CHAR
        LDA #'l'
        JSR PRINT_CHAR
        LDA #'i'
        JSR PRINT_CHAR
        LDA #'c'
        JSR PRINT_CHAR
        LDA #'a'
        JSR PRINT_CHAR
        LDA #'t'
        JSR PRINT_CHAR
        LDA #'i'
        JSR PRINT_CHAR
        LDA #'o'
        JSR PRINT_CHAR
        LDA #'n'
        JSR PRINT_CHAR
        LDA #'!'
        JSR PRINT_CHAR

        ; End program
        BRK

    PRINT_CHAR:
        STA $100
        LDA $FFFE
        JSR $FFEE
        RTS

    PRINT_STRING:
        JSR PRINT_CHAR_LOOP
        RTS

    PRINT_CHAR_LOOP:
        LDA (BUFFER),Y
        BEQ END_PRINT_STRING
        JSR PRINT_CHAR
        INY
        JMP PRINT_CHAR_LOOP
    END_PRINT_STRING:
        RTS

    READ_STRING:
        LDA BUFFER
        CMP #$0D
        BEQ END_READ_STRING
        JSR PRINT_CHAR
        LDA BUFFER
        STA (BUFFER),Y
        INY
        DEX
        BNE READ_STRING
    END_READ_STRING:
        LDA #' '
        STA (BUFFER),Y
        INY
        RTS
