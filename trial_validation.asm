
; Decimal to Binary conversion program in 6502 Assembly
;
; Input:  A - Decimal number to convert (0-255)
; Output: X - Binary representation of the input number
; 
; Example usage:
; LDA #10     ; Load decimal number to convert into the A register
; JSR CONVERT ; Call the conversion subroutine
; 
; CONVERT:
; STA TEMP   ; Store the input number in a temporary location
; LDX #7     ; Set the bit count for 8-bit binary representation
; LDY #0     ; Initialize the binary result
; 
; LOOP:
; LDA TEMP   ; Load the input number
; ASL        ; Shift the accumulator left (multiply by 2)
; BCC ZERO   ; Check if the carry flag is clear
; ORA #1     ; If the carry flag is set, add 1 to the result
; 
; ZERO:
; STA TEMP   ; Store the result back in the temporary location
; ROL        ; Rotate the result left into the carry flag
; STY TEMP   ; Store the carry flag in the result
; DEX        ; Decrement the bit count
; BNE LOOP   ; Repeat until all bits have been processed
; 
; LDX TEMP   ; Load the final binary result into the X register
; RTS        ; Return from subroutine

        .org $0200

DECIMAL_NUMBER  .equ $00
BIT_COUNT       .equ $01
BINARY_RESULT   .equ $02
TEMP            .equ $03

        .org $FFFC
        .word START

START:
        LDA #$0A      ; Load decimal number 10 into the A register
        JSR CONVERT   ; Call the conversion subroutine
        BRK           ; Stop execution

CONVERT:
        STA TEMP      ; Store the input number in a temporary location
        LDX #$07      ; Set the bit count for 8-bit binary representation
        LDY #$00      ; Initialize the binary result

LOOP:
        LDA TEMP      ; Load the input number
        ASL           ; Shift the accumulator left (multiply by 2)
        BCC ZERO      ; Check if the carry flag is clear
        ORA #$01      ; If the carry flag is set, add 1 to the result

ZERO:
        STA TEMP      ; Store the result back in the temporary location
        ROL           ; Rotate the result left into the carry flag
        STY TEMP      ; Store the carry flag in the result
        DEX           ; Decrement the bit count
        BNE LOOP      ; Repeat until all bits have been processed

        LDX TEMP      ; Load the final binary result into the X register
        RTS           ; Return from subroutine

        .org $FD00
        .end
