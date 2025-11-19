
; Binary search program in 6502 Assembly

; Constants
STX $80        ; Store result in $80
STX $81        ; Store upper bound in $81
STX $82        ; Store lower bound in $82

; Input data - sorted list of numbers
LDA #10        ; Number to search for
SEC
SBC #5         ; Middle element of list
STA $83        ; Store middle element in $83

; Initialize upper and lower bounds
LDA #0
STA $81        ; Upper bound
LDA #5
STA $82        ; Lower bound

Loop:
; Compare input number with middle element
LDA $83
CMP $80
BEQ Found       ; Element found

; Check if upper bound < lower bound
LDA $81
CMP $82
BCC NotFound    ; Element not found

; Calculate new middle element
LDA $81
CLC
ADC $82
LSR            ; Divide by 2
STA $84        ; Store new middle element

; Compare input number with new middle element
LDA $84
CMP $80
BCC LowerHalf   ; Search in lower half
JMP UpperHalf

LowerHalf:
STA $81         ; Set upper bound to middle - 1
JMP Loop

UpperHalf:
LDA $80
STA $82         ; Set lower bound to middle + 1
JMP Loop

Found:
LDA $83
STA $80        ; Store index of found element
JMP End

NotFound:
LDA #255       ; Indicate element not found
STA $80
JMP End

End:
; End of program
