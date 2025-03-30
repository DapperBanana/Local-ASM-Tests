
START   LDX #0      ; Initialize index
        LDA #0      ; Initialize recommendation counter
        
LOOP    LDA MESSAGE,X  ; Load message character
        BEQ END      ; If end of message, go to end
        
        JSR $FFD2    ; Print character
        
        INX          ; Increment index
        JMP LOOP     ; Repeat loop
        
END     RTS          ; Return from subroutine

MESSAGE .BYTE "Welcome to the Movie Recommendation System!", $0D, $0A
        .BYTE "We recommend the following movies:", $0D, $0A
        .BYTE "1. The Shawshank Redemption", $0D, $0A
        .BYTE "2. The Godfather", $0D, $0A
        .BYTE "3. The Dark Knight", $0D, $0A
        .BYTE $00
        
        .ORG $FFD2    ; Kernal routine for printing character
        .WORD $FFD2    ; Address of CHROUT Kernal routine
