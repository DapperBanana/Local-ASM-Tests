
; Program to calculate the area of a rectangle given its length and width

        .org $0600     ; Start address of program
        LDA #$0A       ; Load length of rectangle into accumulator
        STA LENGTH     ; Store length in memory
        LDA #$05       ; Load width of rectangle into accumulator
        STA WIDTH      ; Store width in memory
        LDA LENGTH     ; Load length from memory
        LDX WIDTH      ; Load width from memory
        JSR MULTIPLY   ; Calculate area by multiplying length and width
        STA AREA       ; Store result in memory
        HLT            ; Halt program

MULTIPLY:
        CLC            ; Clear carry flag
        LDA #$00       ; Clear result
MULTIPLY_LOOP:
        ADC X#$01      ; Add width to result
        DEX            ; Decrement width
        BNE MULTIPLY_LOOP  ; Repeat until width becomes zero
        RTS            ; Return from subroutine

        .org $0700     ; Memory location for variables
LENGTH  .ds 1         ; Length of rectangle
WIDTH   .ds 1         ; Width of rectangle
AREA    .ds 1         ; Area of rectangle

        .end           ; End of program
