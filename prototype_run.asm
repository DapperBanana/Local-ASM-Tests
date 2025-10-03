
ORG $0200
    LDX #9        ; Initialize X register with the number of elements in the list
    LDA #0        ; Initialize accumulator with 0 to store sum
loop
    LDA list, X   ; Load value from list
    CLC           ; Clear carry flag
    ADC sum       ; Add value to sum
    STA sum       ; Store sum back in memory
    DEX           ; Decrement X
    BNE loop      ; Loop until X is 0
    RTS           ; Return
    
sum    .BYTE 0     ; Variable to store sum
    
list   .BYTE 3, 5, 7, 9, 2, 4, 6, 8, 1    ; List of numbers
    
    INCLUDE "vcs.h"
    .END
