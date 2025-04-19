
; Load the starting address of the file into the X register
    LDX #FILE_START

READ_NEXT_LINE:
    ; Read the next line from the file
    JSR READ_LINE

    ; Print the line to the screen
    JSR PRINT_LINE

    ; Check if we have reached the end of the file
    LDA BUFFER
    BEQ END_OF_FILE

    ; Loop back to read the next line
    JMP READ_NEXT_LINE

END_OF_FILE:
    ; End of the program
    BRK

; Subroutine to read a line from the file
READ_LINE:
    LDA #0
    STA BUFFER_PTR

READ_NEXT_CHAR:
    ; Read a character from the file
    LDA (X)
    STA BUFFER,Y
    INY

    ; Check if we have reached the end of the line
    CMP #','
    BEQ END_OF_LINE

    ; Check if we have reached the end of the file
    CMP #0
    BEQ END_OF_FILE

    ; Loop back to read the next character
    INX
    JMP READ_NEXT_CHAR

END_OF_LINE:
    RTS

; Subroutine to print a line to the screen
PRINT_LINE:
    LDA #0
    STA PRINT_PTR

PRINT_NEXT_CHAR:
    ; Read a character from the buffer
    LDA BUFFER,X

    ; Print the character to the screen
    JSR PRINT_CHAR

    ; Check if we have reached the end of the line
    CMP #0
    BEQ END_OF_PRINT

    ; Loop back to print the next character
    INX
    JMP PRINT_NEXT_CHAR

END_OF_PRINT:
    RTS

; Subroutine to print a character to the screen
PRINT_CHAR:
    ; Output character to screen
    LDA PRINT_PTR
    JSR $FFD2

    ; Increment print pointer
    INX
    STA PRINT_PTR

    RTS

; Data Section
FILE_START:
    .word FILE_DATA

FILE_DATA:
    .ascii "hello,world\n"
    .byte 0

BUFFER:
    .block 256

BUFFER_PTR:
    .byte 0

PRINT_PTR:
    .byte 0
