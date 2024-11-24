
; Program to calculate the area of a pyramid given its base area and height

    ORG $0200        ; Start address

    LDX #0           ; Initialize X register to zero
    LDY #0           ; Initialize Y register to zero
    
    ; Get the base area input
    LDA $1000        ; Load the base area into the accumulator
    STA $FE          ; Store the base area in memory location $FE
    
    ; Get the height input
    LDA $1001        ; Load the height into the accumulator
    STA $FF          ; Store the height in memory location $FF
    
    ; Calculate the area of the pyramid
    LDA $FE          ; Load the base area back into the accumulator
    ADC $FF          ; Add the height to the base area
    STA $FD          ; Store the result in memory location $FD

    ; Output the result
    LDA $FD          ; Load the result back into the accumulator
    STA $1002        ; Store the area of the pyramid in memory location $1002

    BRK              ; End the program
    

    ORG $FFFC        ; Interrupt vector
    .WORD $0200      ; Start address of the program

    ; Input data
    .ORG $1000
    .BYTE 10         ; Base area
    .BYTE 5          ; Height

    ; Output data
    .ORG $1002
    .BYTE 0          ; Area of the pyramid
    
    ; Initialize memory locations
    .ORG $FD
    .BYTE 0          ; Result
    .ORG $FE
    .BYTE 0          ; Base area
    .ORG $FF
    .BYTE 0          ; Height
