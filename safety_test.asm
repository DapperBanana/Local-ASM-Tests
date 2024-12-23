
    .org $0200

    ; Define constants
radius    .byte $05     ; Radius of the circle
PI        .byte $32     ; Value of pi (approx. 3.14)
area      .word 0       ; Variable to store the calculated area

    ; Load radius into accumulator
    LDA #radius            

    ; Square the radius
    STA $FB               ; Store the radius in a temporary memory location
    JSR Square            ; Call subroutine to square the value
    LDA $FC               ; Load the squared value back into the accumulator
    
    ; Multiply by PI
    LDA PI
    STA $FB               ; Store the PI value in a temporary memory location
    JSR Multiply          ; Call subroutine to multiply the squared radius by PI
    LDA $FC               ; Load the calculated area back into the accumulator
    
    ; Store the result in memory
    STA area

    ; Halt the CPU
    BRK

Square: ; Subroutine to square a value
    LDA $FB
    ASL
    STA $FD             ; store the result in a temporary memory location
    LDA $FB
    ASL
    ASL
    ASL
    CLC
    ADC $FD
    STA $FC             ; store the squared value in the accumulator
    RTS

Multiply: ; Subroutine to multiply the squared radius by PI
    LDA $FB
    STA $FD             ; Store the squared radius in a temporary memory location
    LDA $FD
    CLC
    ADC $FD             ; Multiply by 2
    STA $FD
    LDA $FD
    CLC
    ADC $FD             ; Multiply by 3
    STA $FD
    LDA PI
    CLC
    ADC $FD             ; Multiply by PI
    STA $FC             ; Store the result in the accumulator
    RTS
