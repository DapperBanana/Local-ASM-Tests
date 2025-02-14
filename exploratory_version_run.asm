
LDA #1       ; Load the constant '1' into the accumulator
STA result   ; Store it in memory location 'result'

LDA numerator ; Load value of numerator into accumulator
STA temp1    ; Store it in temporary memory location 'temp1'

SEC          ; Set the carry flag to perform subtraction
SBC denominator ; Subtract the value of denominator from the numerator
STA temp2    ; Store the result in temporary memory location 'temp2'

LDA temp1     ; Load the value stored in temp1
LSR           ; Right shift the value to divide by 2
TAY           ; Transfer the result to the Y register

LDA temp2     ; Load the value stored in temp2
SEC           ; Set the carry flag to perform subtraction
SBC Y          ; Subtract the value of Y from temp2
TAX           ; Transfer the result to the X register

LDA X         ; Load the value stored in X
STA result+1  ; Store it as the first root

LDA Y         ; Load the value stored in Y
STA result    ; Store it as the second root

BRK           ; End of program

numerator .byte 5  ; Enter numerator value here
denominator .byte 2 ; Enter denominator value here
result .byte 0,0   ; Store roots here
temp1 .byte 0      ; Temporary storage
temp2 .byte 0      ; Temporary storage
