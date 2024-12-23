
; Calculate distance between two points in 3D space

        ORG $1000

point1x .BYTE $05   ; X coordinate of Point 1
point1y .BYTE $08   ; Y coordinate of Point 1
point1z .BYTE $0B   ; Z coordinate of Point 1

point2x .BYTE $0B   ; X coordinate of Point 2
point2y .BYTE $08   ; Y coordinate of Point 2
point2z .BYTE $05   ; Z coordinate of Point 2

result  .WORD $0000 ; Placeholder for the result

        LDX #point2x   ; Load X coordinate of Point 2 into X register
        LDA point2x,X  ; Load X coordinate of Point 2 into accumulator
        STA $FE        ; Store X coordinate of Point 2 in $FE
        LDA point1x,X  ; Load X coordinate of Point 1 into accumulator
        STA $FD        ; Store X coordinate of Point 1 in $FD

        LDX #point2y   ; Load Y coordinate of Point 2 into X register
        LDA point2y,X  ; Load Y coordinate of Point 2 into accumulator
        STA $FB        ; Store Y coordinate of Point 2 in $FB
        LDA point1y,X  ; Load Y coordinate of Point 1 into accumulator
        STA $FA        ; Store Y coordinate of Point 1 in $FA

        LDX #point2z   ; Load Z coordinate of Point 2 into X register
        LDA point2z,X  ; Load Z coordinate of Point 2 into accumulator
        STA $F9        ; Store Z coordinate of Point 2 in $F9
        LDA point1z,X  ; Load Z coordinate of Point 1 into accumulator
        STA $F8        ; Store Z coordinate of Point 1 in $F8

        CLC            ; Clear the carry flag
        LDA $FE        ; Load X coordinate of Point 2 into accumulator
        SEC            ; Set the carry flag
        SBC $FD        ; Subtract X coordinate of Point 1 from accumulator
        ASL            ; Multiply the result by 2
        STA $EC        ; Store the squared difference in $EC

        LDA $FB        ; Load Y coordinate of Point 2 into accumulator
        SEC            ; Set the carry flag
        SBC $FA        ; Subtract Y coordinate of Point 1 from accumulator
        ASL            ; Multiply the result by 2
        STA $EA        ; Store the squared difference in $EA

        LDA $F9        ; Load Z coordinate of Point 2 into accumulator
        SEC            ; Set the carry flag
        SBC $F8        ; Subtract Z coordinate of Point 1 from accumulator
        ASL            ; Multiply the result by 2
        STA $E8        ; Store the squared difference in $E8

        LDA $EC        ; Load the squared difference of X coordinates into accumulator
        CLC            ; Clear the carry flag
        ADC $EA        ; Add the squared difference of Y coordinates to accumulator
        ADC $E8        ; Add the squared difference of Z coordinates to accumulator

        STA result     ; Store the result in the result variable

        BRK            ; Exit the program

        .END
