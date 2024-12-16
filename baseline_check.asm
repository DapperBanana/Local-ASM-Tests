
; Define some constants
DEFINETEXT = $200 ; Memory address to store text data
CARD1 = $300 ; Memory address for card 1 data
CARD2 = $310 ; Memory address for card 2 data

; Start of the program
.ORG $1000

START:
    LDA #<MSG1 ; Load low byte of MSG1 address
    STA DEFINETEXT ; Store it in DEFINETEXT memory address
    LDA #>MSG1 ; Load high byte of MSG1 address
    STA DEFINETEXT+1 ; Store it in DEFINETEXT+1 memory address

    ; Display card 1
    LDA #<CARD1 ; Load low byte of CARD1 address
    STA DEFINETEXT ; Store it in DEFINETEXT memory address
    LDA #>CARD1 ; Load high byte of CARD1 address
    STA DEFINETEXT+1 ; Store it in DEFINETEXT+1 memory address
    JSR DISPLAY ; Call display subroutine

    ; Display card 2
    LDA #<CARD2 ; Load low byte of CARD2 address
    STA DEFINETEXT ; Store it in DEFINETEXT memory address
    LDA #>CARD2 ; Load high byte of CARD2 address
    STA DEFINETEXT+1 ; Store it in DEFINETEXT+1 memory address
    JSR DISPLAY ; Call display subroutine
    
    ; End of the program
    BRK

MSG1: .BYTE "Welcome to the Trading Card Game!",0
CARD1: .BYTE "Card 1: Power - 10, Defense - 5",0
CARD2: .BYTE "Card 2: Power - 8, Defense - 7",0

DISPLAY:
    LDX #0 ; Initialize X register
LOOP:
    LDA DEFINETEXT,X ; Load a character from memory
    BEQ DONE ; If it's the end of string, exit the loop
    JSR $FFD2 ; Print the character to screen
    INX ; Increment X register
    JMP LOOP ; Repeat the loop
DONE:
    RTS ; Return from subroutine

.END
