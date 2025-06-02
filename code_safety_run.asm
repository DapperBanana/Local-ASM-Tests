
; Program to calculate the area of a parallelogram

; Input: Base and Height of parallelogram in memory locations BASE and HEIGHT
; Output: Area of parallelogram in memory location AREA

        LDA BASE    ; load base of parallelogram
        STA $FB     ; store it in memory location $FB

        LDA HEIGHT  ; load height of parallelogram
        STA $FC     ; store it in memory location $FC

        LDA $FB     ; load base from memory
        CLC         ; clear the carry flag
        ADC $FC     ; add height to base
        STA $FA     ; store the result in memory location $FA

        LDA $FB     ; load base from memory
        STA $F9     ; store it in memory location $F9

        LDA $FC     ; load height from memory
        STA $F8     ; store it in memory location $F8

        LDA $F9     ; load base from memory
        CLC         ; clear the carry flag
        ADC $FA     ; add height to base
        STA $FD     ; store the result in memory location $FD

        LDA $FD     ; load the area of parallelogram
        STA AREA    ; store it in memory location AREA

        BRK         ; end program

BASE    .BYTE  5    ; base of parallelogram
HEIGHT  .BYTE  3    ; height of parallelogram
AREA    .BYTE  0    ; area of parallelogram
