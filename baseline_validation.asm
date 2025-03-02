
        .org    $5000

        LDA     #5         ; Load side a with value 5
        STA     side_a     

        LDA     #6         ; Load side b with value 6
        STA     side_b

        LDA     #7         ; Load side c with value 7
        STA     side_c

        LDA     side_a     ; Load side a
        CLC
        ADC     side_b     ; Add side b
        CLC
        ADC     side_c     ; Add side c
        STA     perimeter  ; Store the perimeter of the triangle

        LDA     perimeter  ; Load the perimeter of the triangle
        SEC
        SBC     side_a     ; Subtract side a
        STA     temp       ; Store the result in temp

        LDA     perimeter  ; Load the perimeter of the triangle
        SEC
        SBC     side_b     ; Subtract side b
        STA     temp       ; Store the result in temp

        LDA     perimeter  ; Load the perimeter of the triangle
        SEC
        SBC     side_c     ; Subtract side c
        STA     temp       ; Store the result in temp

        LDA     perimeter  ; Load the perimeter of the triangle
        SEC
        SBC     #1         ; Subtract 1
        LSR     A          ; Divide by 2
        STA     area       ; Store the area of the triangle

        BRK

side_a  .byte   0
side_b  .byte   0
side_c  .byte   0
perimeter .byte  0
temp    .byte   0
area    .byte   0

        .end
