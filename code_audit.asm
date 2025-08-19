
; Define constants
.equ BASE_LENGTH, 5
.equ HEIGHT, 4
.equ SQRT3, 1.73205

; Calculate area of regular tetrahedron
ldx #BASE_LENGTH
ldy #HEIGHT
ldz #SQRT3

; Calculate area using formula (base_length * height) / 2
mul x, y    ; Muliply base_length and height
div z       ; Divide by square root of 3 to get final area

; Store the result in memory location
sta AREA_RESULT

loop:
    jmp loop    ; Endless loop

; Result stored in memory location AREA_RESULT
AREA_RESULT: .byte 0

.end
