
; Define the data
DataStart:
    .byte $05, $0A, $07, $0D, $03  ; Y values, representing the data points
DataEnd:
DataSize = DataEnd - DataStart

; Main program
start:
    ldx #0  ; Initialize index to loop through data
loop:
    lda DataStart, x  ; Load the Y value
    sta $FB  ; Store Y value in a temp register
    lda #$20  ; Load the X axis position
    sta $FA  ; Store X axis position in a temp register
    jsr drawPoint  ; Call subroutine to draw the point
    inx  ; Increment index
    cpx DataSize  ; Check if reached end of data
    bne loop  ; Loop back if not
    
end:
    rts

; Subroutine to draw a point on the chart
drawPoint:
    ldy $FB  ; Load Y value
    ldx $FA  ; Load X value
    lda #$2A  ; Load character to represent the point
    sta $0400, y  ; Store character at (X,Y) position on the screen
    rts
