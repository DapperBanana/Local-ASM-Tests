
    .text
    .globl _start

_start:
    LDA #0          ; Initialize counter
    STA $00         ; Initialize reservation counter

prompt:
    LDX $00         ; Load reservation counter
    CMP #10         ; Check if all flights are reserved
    BEQ full        ; Branch to full if all flights are reserved

    LDX $00         ; Load reservation counter
    CLC
    ADC #1          ; Increment reservation counter
    STA $00         ; Store new reservation counter

    LDA $00         ; Load reservation counter
    ASL             ; Multiply by 2 to get memory address for reservation status
    TAX

input:
    LDA #0          ; Initialize character input
    JSR $FFE1       ; Get character input

    CMP #10         ; Check if Return key is pressed
    BEQ confirm     ; Branch to confirm if Return key is pressed

    STA $0200, X    ; Store input in memory

    JMP input

confirm:
    LDA $0200, X    ; Load input
    CMP #"Y"        ; Check if input is "Y" for yes
    BEQ success     ; Branch to success if input is "Y"

    LDA $00         ; Load reservation counter
    CLC
    SBC #1          ; Decrement reservation counter
    STA $00         ; Store new reservation counter

    LDA $00         ; Load reservation counter
    ASL             ; Multiply by 2 to get memory address for reservation status
    TAX

    LDA #0          ; Clear previous input
    STA $0200, X

    JMP prompt

success:
    LDA #"R"        ; Reservation successful message
    JSR $FFD2       ; Print message

    JMP prompt

full:
    LDA #"A"        ; All flights reserved message
    JSR $FFD2       ; Print message

    JMP prompt
