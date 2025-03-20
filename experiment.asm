
; Chatbot program in 6502 Assembly
; Simulates a basic text-based chatbot by responding to user input

    .org $2000

    ; Set up input and output
    .word $C000 ; Input buffer
    .word $D000 ; Output buffer

    ; Start of program
    LDA #$00
    STA $FFFC     ; Set up stack pointer
    LDX #$00
    STX $D020     ; Set cursor to beginning of output buffer
    
main_loop:
    ; Get user input
    LDA $C000,x ; Load character from input buffer
    CMP #$00     ; Check for end of input
    BEQ exit     ; Exit program if end of input
    STA $D000,x ; Copy character to output buffer
    INX          ; Increment index
    JMP main_loop ; Repeat process
    
exit:
    BRK  ; End program

    .end 
