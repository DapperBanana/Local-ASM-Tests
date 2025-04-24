
; Load the address of the file into memory
    LDX #file_address ; Load the address of the file into X register
    LDA #00           ; Load the address offset into A register

load_csv:
    LDA (X),Y         ; Load the next byte from the file into accumulator
    CMP #00           ; Compare the byte to null terminator
    BEQ end_of_file   ; Branch to end_of_file if null terminator is found
    
    JSR print_char   ; Print the character in accumulator
    INY              ; Increment Y register to move to the next byte
    JMP load_csv     ; Repeat the process for next byte

end_of_file:
    RTS               ; Return from subroutine
    
print_char:
    STA $02           ; Store the character in accumulator to memory location $02
    LDA $02           ; Load the character from memory to accumulator
    JSR $FFD2         ; Call KERNAL routine to print the character
    RTS               ; Return from subroutine

file_address:
    .byte $04         ; Address of the CSV file in memory

