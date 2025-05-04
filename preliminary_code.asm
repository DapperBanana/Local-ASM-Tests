
        .org $0200

start   lda #0          ; Initialize accumulator A to 0
        sta area        ; Store 0 in memory location 'area'
        
        lda #6          ; Load the number 6 to accumulator A
        sta sides       ; Store 6 in memory location 'sides'
        
        lda #10         ; Load the number 10 to accumulator A, representing the side length of the hexagon
        sta side_length ; Store 10 in memory location 'side_length'

loop    lda sides       ; Load the number of sides from memory
        beq done        ; If all sides have been processed, jump to 'done'
        
        lda side_length  ; Load the side length from memory
        asl             ; Multiply the side length by 2 (shift left once)
        sta temp        ; Store the result in memory location 'temp'
        
        lda temp        ; Load the temporary value into accumulator A
        clc             ; Clear the carry flag
        adc area        ; Add the temporary value to the current area
        sta area        ; Store the result in memory location 'area'
        
        dex             ; Decrement the number of sides
        bne loop        ; If there are more sides remaining, repeat the loop
        
done    lda area        ; Load the final area value into accumulator A
        ; Output the result here
        
        rts             ; Return from subroutine

        .org $FFFC
        .word start     ; Set reset vector to start of program

area        .byte 0
sides       .byte 0
side_length .byte 0
temp        .byte 0

        .end
