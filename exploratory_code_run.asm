
 ; Define constants for the dimensions of the trapezoidal prism
top_base equ 10
bottom_base equ 5
height equ 8
side_length equ 6

 ; Calculate the area of the top and bottom trapezoidal faces
lda top_base
clc
adc bottom_base
asl
sta total_area ; total_area = (top_base + bottom_base) * height

lda height
lsl
adc total_area
sta total_area

 ; Calculate the area of the four rectangular sides
lda side_length
clc
adc side_length
asl
sta side_area ; side_area = 2 * side_length * height

lda height
lsl
adc side_area
sta side_area

 ; Calculate the total surface area of the trapezoidal prism
lda total_area
clc
adc side_area
sts total_area

 ; Display the result
ldx #0
ldy #total_area
sta $3000,x
inx
lda #$00
sta $3000,x

 ; Halt
halt: jmp halt
