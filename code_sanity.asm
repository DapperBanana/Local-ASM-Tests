
.include "6502.inc"

ORG $0200

LDX #0          ; Initialize index low
LDY #9          ; Initialize index high
LDA #5          ; Search value
JSR BinarySearch

BRK

BinarySearch:
    LSR          ; Divide by 2
    TAX          ; Save index middle
    LDA ($01,X)  ; Load value at index middle
    CMP #$00      ; Check if end of list
    BEQ NotFound  ; Branch if not found
    CMP #$5       ; Compare value
    BEQ Found     ; Branch if found
    BCC LessThan  ; Branch if the value is less than the searched value
    
GreaterThan:
    DEY          ; Decrement high index
    JMP BinarySearch

LessThan:
    INX          ; Increment low index
    JMP BinarySearch

NotFound:
    LDA #$FF      ; Set result as not found
    RTS

Found:
    LDX #0        ; Set result as found
    RTS

.END
