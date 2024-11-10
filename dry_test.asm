
LDA #<CSV_FILE_ADDR ; Load low byte of address of CSV file into A
LDX #>CSV_FILE_ADDR ; Load high byte of address of CSV file into X
LDY #0 ; Initialize index Y to zero

READ_LOOP:
LDA (X),Y ; Load byte from CSV file into A
CMP #"," ; Compare byte to comma
BEQ PRINT_CHAR ; Branch to PRINT_CHAR if byte is comma
CMP #"\n" ; Compare byte to newline character
BEQ END ; Branch to END if byte is newline character

PRINT_CHAR:
JSR $FFD2 ; Call KERNAL routine to print character in A
INY ; Increment index Y
JMP READ_LOOP ; Loop back to READ_LOOP

END:
RTS ; Return from subroutine

CSV_FILE_ADDR: .BYTE $00 ; Address of CSV file
