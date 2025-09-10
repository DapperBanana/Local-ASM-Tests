
        .org $0200

start   LDX #3        ; Load the side length of the cube into X register
        LDY #6        ; Load the number of faces of a cube into Y register
        LDA #0        ; Clear accumulator
        STA result    ; Initialize result to 0

loop    DEY           ; Decrement Y (number of faces)
        BEQ done      ; If Y = 0, jump to done

        TAX           ; Copy X to Y
        TYA           ; Copy Y to A
        JSR multiply  ; Call multiply subroutine

        LDX result    ; Load result
        LDY #4        ; Load the number of square faces of a cube into Y
        JSR multiply  ; Call multiply subroutine

        LDX result    ; Load result
        LDA #2        ; Load the number of identical square faces of a cube into A
        JSR multiply  ; Call multiply subroutine

        STA result    ; Store the result

        JMP loop      ; Repeat loop

done    BRK           ; Exit program

multiply
        CLC           ; Clear carry
        LDA result    ; Load result into A
        ADC X         ; Add X to A
        STA result    ; Store sum back in result
        RTS           ; Return from subroutine

result  .byte 0        ; Result variable

        .end
