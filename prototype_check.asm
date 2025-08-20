
ORG $2000

; Constants
m         = $FFD0
b         = $FFD2
sum_x     = $FFD4
sum_y     = $FFD6
sum_x_sq  = $FFD8
sum_xy    = $FFDA
n         = $FFDC

; Starting address of input data
data_start = $1000

start:
    LDA #$00           ; Initialize sum_x, sum_y, sum_x_sq, sum_xy, and n to zero
    STA sum_x
    STA sum_y
    STA sum_x_sq
    STA sum_xy
    STA n

    LDX #0             ; Initialize index to 0
loop:
    LDA data_start,X   ; Load X value into A
    STA $FFDE          ; Store X value in temp location
    LDA data_start+1,X ; Load Y value into A
    STA $FFDF          ; Store Y value in temp location

    CLC
    ADC sum_x          ; Add X to sum_x
    STA sum_x

    CLC
    ADC sum_y          ; Add Y to sum_y
    STA sum_y

    LDA $FFDE
    CLC
    ADC sum_x_sq       ; Add X^2 to sum_x_sq
    STA sum_x_sq

    LDA $FFDE
    ADC $FFDF          ; Add X * Y to sum_xy
    STA sum_xy

    INC n              ; Increment n

    INX                ; Increment index
    CPX #10            ; Check if all data points processed
    BNE loop

    LDA sum_x
    STA $FFDC          ; Store n in n variable

    SEC
    LDA sum_x
    SBC sum_x/n        ; Calculate mean of X values
    STA sum_x

    SEC
    LDA sum_y
    SBC sum_y/n        ; Calculate mean of Y values
    STA sum_y

    LDA sum_x_sq
    CLC
    ADC (-$FFDC)       ; Calculate sum of squares of X values
    STA sum_x_sq

    LDA sum_xy
    CLC
    ADC (-$FFDC)*sum_y ; Calculate sum of product of X and Y values
    STA sum_xy

    LDA sum_xy
    SEC
    SBC sum_x*sum_y    ; Calculate numerator of m
    STA m

    LDA m
    CLC
    ADC #0             ; Calculate m

    LDA sum_y
    SEC
    SBC m*sum_x        ; Calculate b
    STA b

    ; Output results
    LDA m
    STA $FF00          ; Store m in memory
    LDA b
    STA $FF02          ; Store b in memory

end:
    JMP end            ; End program

.END
