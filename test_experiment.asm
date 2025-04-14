
CLD         ; Clear the decimal mode
LDA #7      ; Load the number of sides of the heptagon
STA sides   ; Store it in a memory location
LDA #100    ; Load the length of each side
STA length  ; Store it in a memory location

LDA sides   ; Load the number of sides
ASL         ; Multiply by 2 to get the number of diagonals
TAX         ; Store the result in X register

LDA length  ; Load the length of each side
STA diagonal ; Store it in a memory location

LDA diagonal  ; Load the length of each diagonal
CLC          ; Clear the carry flag
ADC diagonal ; Add the length of each side to get the perimeter
TAY          ; Store the result in Y register

TYA          ; Load the perimeter
TAX          ; Store it in X register

LDA $00      ; Load the number of sides
CLC          ; Clear the carry flag
ADC $00      ; Add 1 to the number of sides for the formula
STA sides    ; Store the result back in memory
LDA sides    ; Load the number of sides
ASL          ; Multiply by 2 to get the number of interior angles
TAY          ; Store the result in Y register

TYA          ; Load the number of interior angles
DEY          ; Decrement to get the number of triangles formed by the diagonals
TAX          ; Store the result in X register

TYA          ; Load the number of triangles formed by the diagonals
SBC sides    ; Subtract the number of sides to get the number of triangles inside the heptagon
TAY          ; Store the result in Y register

LDA diagonal ; Load the length of each diagonal
STA $00      ; Store it in a temporary memory location

LDA sides    ; Load the number of sides
ASL          ; Multiply by 2 to get the number of interior angles
TAX          ; Store the result in X register

LDA $00      ; Load the length of each diagonal
CLC          ; Clear the carry flag
ADC $00      ; Add the length of each diagonal
TAY          ; Store the result in Y register

TYA          ; Load the length of each diagonal
TYA          ; Load the length of each diagonal
TAX          ; Store it in X register

LDA $00      ; Load the length of each diagonal
TAX          ; Store it in X register

LDA $00      ; Load the length of each diagonal
TAX          ; Store it in X register

LDA $00      ; Load the length of each diagonal
TAX          ; Store it in X register

LDA $00      ; Load the length of each diagonal
TAX          ; Store it in X register

LDA $00      ; Load the length of each diagonal
TAX          ; Store it in X register

LDA $00      ; Load the length of each diagonal
TAX          ; Store it in X register

LDA $00      ; Load the length of each diagonal
TAX          ; Store it in X register

LDA $00      ; Load the length of each diagonal
TAX          ; Store it in X register
