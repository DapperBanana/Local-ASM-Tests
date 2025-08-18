
        .org $0200 ; Start the program at memory address $0200

start:
        ; Setup file reading
        LDX #$22 ; file pointer (replace with actual memory address of file location)
        
read_loop:
        LDA (X),Y ; Load character from file
        BEQ end_file ; Exit loop if end of file is reached

        ; Check for key
        CMP #$22 ; Compare to ASCII value of "
        BEQ read_key ; Branch if character is "
        
        ; Check for value
        CMP #$3A ; Compare to ASCII value of :
        BEQ read_value ; Branch if character is :

        ; Print character to console
        JSR $FFD2 ; Output character to console
        INX ; Increment file pointer
        BRA read_loop ; Continue looping
        
read_key:
        ; Print key to console 
        ; (Note: You will need to handle storing key characters and formatting output)
        JSR $FFD2 ; Output key character to console
        INX ; Increment file pointer
        BRA read_loop ; Continue looping

read_value:
        ; Print value to console
        ; (Note: You will need to handle storing value characters and formatting output)
        JSR $FFD2 ; Output value character to console
        INX ; Increment file pointer
        BRA read_loop ; Continue looping

end_file:
        ; End of file reached, exit program
        BRK ; Break and end program execution

        .end ; End of program
