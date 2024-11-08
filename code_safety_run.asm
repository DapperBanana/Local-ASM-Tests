
.INCLUDE "c64.inc"
.SECTION CODE

* Initialize variables
start:  LDX #$00        ; Initialize counter
        LDY #$08        ; Set password length to 8 characters

* Generate random password
loop:   JSR RANDOM     ; Get random number
        AND #$3F        ; Mask out upper bits
        CMP #$20        ; Check if character is printable
        BCC loop        ; If not, try again
        STA $0200,X     ; Store character in memory
        INX             ; Increment counter
        BNE loop        ; Continue until 8 characters are generated
        DEY             ; Decrement length counter
        BNE loop        ; Repeat for next character

* Display generated password
        LDX #$00
print:  LDA $0200,X     ; Load character from memory
        JSR $FFD2       ; Output character to screen
        INX             ; Increment counter
        CPX #$08        ; Check if all characters have been printed
        BNE print       ; Repeat until all characters are printed

* End program
        RTS

* Random number generator routine
RANDOM: LDA $D012       ; Read raster line value
        ASL             ; Shift left to multiply by 2
        ADC #$01        ; Adjust to ensure positive result
        RTS

.SECTION BSS

* Variable for storing generated password
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00

.END
