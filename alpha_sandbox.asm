
        ORG $0200

        LDA #9          ; Number of sides
        STA sides

        LDA #10         ; Length of each side
        STA length

        LDX #0
        LDY #0

loop:   INX             ; Loop through each side
        CPX sides       ; Compare with number of sides
        BEQ finish
      
        LDA length
        CLC
        ADC Y
        STA Y           ; Calculate perimeter of polygon

        INY             ; Increase index for next side
        JMP loop
        
finish: LDA Y           ; Now, Y contains perimeter of polygon
        LDX length
        STA temp        ; Store length in temp
        LDA #2
        STA divisor     ; Divide by 2
        JSR divide

        LDA X           ; Get half of perimeter
        STA halfperimeter

area:   LDA #2          ; Initialize '2'
        CLC             
        ADC sides       ; Add number of sides
        JSR multiply

        LDX X           ; Get result of multiplication
        LDA halfperimeter
        STA temp        ; Store half perimeter
        JSR divide

        LDA temp        ; Now, temp contains apothem of polygon
        STA apothem

        LDA apothem
        CLC
        ADC temp        ; Calculate area of polygon
        STA area

        HLT

divide: LDA #0          ; Initialize quotient
        STA quotient
        LDA Y           ; Get dividend in A
        CMP #0
        BEQ reset
        LDA divisor
        STA div
division:ADC div         ; Perform division
        BCC subtract
        DEC Y
        INC quotient
        JMP division
subtract:SEC
        SBC div
        JMP division
reset:  LDA quotient
        STA X           ; Store quotient in X
        RTS

multiply:
        LDA #0          ; Initialize product
        STA product
        LDX #0
        LDY #0
mul_loop:
        CPX divisor
        BEQ end_multiply
        ADC Y           ; Add multiplier to product
        INY             ; Increment multiplier
        JMP mul_loop
end_multiply:
        STA product
        RTS

sides:  .BYTE 0
length: .BYTE 0
halfperimeter: .BYTE 0
divisor: .BYTE 0
quotient: .BYTE 0
product: .BYTE 0
apothem: .BYTE 0
temp:   .BYTE 0
area:   .BYTE 0

        END
