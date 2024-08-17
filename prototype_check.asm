
start:
    lda $01    ; Load the number of sides of the hexadecagon
    cmp #$10    ; Compare with 16
    bne invalid_input  ; If not equal, go to invalid_input
    
    lda $02    ; Load the side length of the hexadecagon
    jsr multiply    ; Call the multiply subroutine to square the side length
    
    lda $01    ; Load the number of sides
    jsr convert_to_radians    ; Convert the number of sides to radians
    jsr tan_half_angle    ; Calculate the tangent of half the angle
    
    jsr multiply    ; Multiply the squared side length by the tangent
    
    sta $03    ; Store the result in memory
    
    ; Output the result
    lda $03    ; Load the result
    sta $fe    ; Store in memory for output
    lda $03  
    lsr    ; Shift right to get the decimal portion
    sta $ff    ; Store in memory for output
    lda #$2C    ; Load comma character (",")
    sta $01    ; Store in memory for output
    lda #$27    ; Load single quote character ("'")
    sta $02    ; Store in memory for output
    lda #$00    ; Load null character for end of string
    sta $03    ; Store in memory for output
    
    jsr output    ; Call the output subroutine
    
end:
    rts    ; Return from subroutine

invalid_input:
    lda #$49    ; Load 'I' character for "Invalid Input"
    sta $fe
    lda #$6E    ; Load 'n' character
    sta $ff
    lda #$76    ; Load 'v' character
    sta $01
    lda #$61    ; Load 'a' character
    sta $02
    lda #$6C    ; Load 'l' character
    sta $03
    lda #$69    ; Load 'i' character
    sta $04
    lda #$64    ; Load 'd' character
    sta $05
    lda #$20    ; Load space character
    sta $06
    lda #$49    ; Load 'I' character
    sta $07
    lda #$6E    ; Load 'n' character
    sta $08
    lda #$70    ; Load 'p' character
    sta $09
    lda #$75    ; Load 'u' character
    sta $0A
    lda #$74    ; Load 't' character
    sta $0B
    
    jsr output    ; Call the output subroutine
    
    rts    ; Return from subroutine

multiply:
    sta $04    ; Store the value in memory
    ldx #$02    ; Load the index for loop
loop:
    lda $04    ; Load value to be multiplied
    clc    ; Clear carry
    adc $04    ; Add to itself
    sta $04    ; Store the result
    dex    ; Decrease index
    bne loop    ; Continue loop until index is zero
    rts    ; Return from subroutine

convert_to_radians:
    ldx #$00    ; Set index to zero
    lda $01    ; Load the number of sides
    sta $04    ; Store in memory for manipulation
    
    ldy #$00    ; Clear Y register for high byte of LDA
loop:
    lda $04    ; Load the number of sides
    clc    ; Clear carry
    adc #$00    ; Increment by 1
    sta $04    ; Store the result back
    ldy #$00    ; Initialize Y register to zero
    bne loop    ; Loop until number of sides is reached
    
    lda $04    ; Load the number of sides
    sta $05    ; Store the result
    
    lda #$2C    ; Load the constant value of 360
    sta $06    ; Store the result
    
    lda $05    ; Load the result
    sta $01    ; Store it for further calculation
    
    lda #$00    ; Load zero to initialize it
    sta $02    ; For manipulation
    
    lda $06    ; Load 360
    sta $02    ; Store in accumulator
    lda #$00    ; Load zero to increment by 1
    sta $03    ; Store in memory
    
    ldx #$00
loop2:
    lda $01    ; Load the dividend
    clc
    adc $03    ; Add by 1
    sta $01    ; Store the result
    
    lda $01    ; Load the dividend
    ldx #$00
    stx $04
    ldy #$00    ; Clear Y register
    
    cpx $02    ; Compare with 2
    bne multiply    ; If not equal, go to multiply
    
    ldx $01    ; Load the result
    dex    ; Decrease by 1
    lda $05    ; Load the number of sides
    txs    ; Transfer x to stack
    
    lda $05    ; Load the number of sides
    sty $00    ; Store in memory
    ldx #$00    ; Load 0
    
    rts    ; Return from subroutine

tan_half_angle:
    ldx #$00    ; Initialize X register to zero
    
    lda #$20    ; Load the value of 32
    sta $04    ; Store in memory
    
    lda #$2C    ; Load the value of 44
    sta $05    ; Store in memory
    
    lda $04    ; Load the value
    stx $00    ; Store the value
    
    lda $05    ; Load the value
    stx $00    ; Store the value
    
    lda $00    ; Load the value
    cmp $00    ; Compare with itself
    bne multiply    ; If not equal, go to multiply
    
    rts    ; Return from subroutine

output:
    lda #$01    ; Set the X register for screen output
    jsr $FFD2    ; Call the Kernal Display Subroutine at $FFD2
    lda #$00    ; Set the X register back to zero
    rts    ; Return from subroutine
