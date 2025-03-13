
; Program to calculate area of a rectangle given its length and width

        .org $1000      ; Starting address

start:
        LDA #10         ; Load length into A register
        STA length

        LDA #5          ; Load width into A register
        STA width

        LDA length      
        CLC             ; Clear carry
        ADC width       ; Add width to length
        STA result      ; Store result in memory location

        HLT             ; Halt the program

length: .byte 0
width:  .byte 0
result: .byte 0

        .end

