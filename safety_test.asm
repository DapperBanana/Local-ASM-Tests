
    .org $0200  ; Start address of program
    
    JMP START   ; Start program execution
    
    ; Variables
    BUFFER .DS 255  ; Buffer to store file contents
    FILENAME .AS "data.csv", $00  ; Name of CSV file
    
START:
    LDX #$00    ; Initialize index register
    
    ; Open file for reading
    LDA #6      ; File mode (read)
    JSR OPEN    ; Call OPEN subroutine
    BMI ERROR   ; Handle error if file could not be opened
    
READ_LOOP:
    ; Read a character from file
    LDA #1      ; Number of bytes to read
    JSR READ    ; Call READ subroutine
    BPL PROCESS_CHAR   ; Branch if read successful
    BNE DONE        ; Exit loop if end of file reached
    
PROCESS_CHAR:
    STA BUFFER,X    ; Store character in buffer
    INX             ; Increment buffer index
    JMP READ_LOOP   ; Continue reading file
    
DONE:
    LDA BUFFER,X   ; Load last character read (EOF marker)
    BEQ CLOSE       ; Branch if end of file marker
    
ERROR:
    ; Handle error
    JSR PRINT_ERROR ; Print error message
    JMP CLOSE       ; Close file and exit program
    
CLOSE:
    JSR CLOSE       ; Close file
    RTS             ; Return from subroutine

; Subroutines

OPEN:
    ; Open file for reading
    JSR $FFC5     ; Kernal routine to open file
    BPL OPEN_OK   ; Branch if file opened successfully
    SEC           ; Set carry flag to indicate error
    RTS           ; Return from subroutine
    
OPEN_OK:
    RTS           ; Return from subroutine
    
READ:
    ; Read bytes from file
    JSR $FFBD    ; Kernal routine to read bytes
    RTS          ; Return from subroutine
    
CLOSE:
    ; Close file
    JSR $FFC8    ; Kernal routine to close file
    RTS          ; Return from subroutine
    
PRINT_ERROR:
    ; Print error message
    LDX #0
    LDA ERROR_MESSAGE,X
    BEQ END_PRINT_ERROR
    JSR $FFD2    ; Kernal routine to print character
    INX
    JMP PRINT_ERROR

END_PRINT_ERROR:
    RTS

; Error message
ERROR_MESSAGE .AS "Error opening file", $00

    .end
