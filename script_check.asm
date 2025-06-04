
        .org $0200
        
start   lda     #5             ; Load the number of sides (s) of the pentagon
        sta     sides
        
        lda     #10            ; Load the length of each side (a) of the pentagon
        sta     side_length
        
        lda     sides          ; Load the number of sides into the X register
        clc
        adc     #$02           ; Add 2 to the sides to calculate the number of triangles (n) in the pentagon
        sta     num_triangles
        
        lda     side_length    ; Load the side length into the Y register
        clc
        adc     side_length    ; Add the side length to calculate the perimeter (p) of the pentagon
        tax
        
        ldx     num_triangles  ; Load the number of triangles into the X register
        
loop    dex                     ; Decrement X
        lda     perimeter       ; Load the perimeter into the accumulator
        clc
        adc     perimeter       ; Add the perimeter
        sta     perimeter       ; Store the new perimeter
        
        cpx     #$00            ; Check if X is zero
        bne     loop            ; If X is not zero, continue looping
        
        lda     perimeter       ; Load the perimeter into the accumulator
        clc
        adc     perimeter       ; Add the perimeter to calculate the total perimeter (2p)
        
        lsr                     ; Divide the result by 2
        sta     total_perimeter
        
        lda     total_perimeter ; Load the total perimeter into the accumulator
        clc
        adc     #100            ; Add 100 to calculate the area (A) of the pentagon
        sta     area
        
done    jmp     done            ; End of program

sides           .byte   0
side_length     .byte   0
num_triangles   .byte   0
perimeter       .byte   0
total_perimeter .byte   0
area            .byte   0

        .end
