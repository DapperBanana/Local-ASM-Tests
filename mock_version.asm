
.org $0200

start:
    ldx #0         ; Initialize sum to 0
    lda num        ; Load number to check
    ldy #10        ; Load divisor
divideLoop:
    cpx #0         ; Check if number is zero
    beq checkSum   ; If zero, go to checkSum
    tax            ; Transfer A to X
    lda num        ; Load number to check
    lsr            ; Divide by 10
    sta num        ; Save new number
    clc            ; Clear carry flag
    adc #$30       ; Convert ASCII to integer
    tax            ; Save result in X
    inx            ; Increment sum
    cpx #0         ; Check if number is zero
    bne divideLoop ; If not zero, go to divideLoop

checkSum:
    lda #0         ; Load 0 into A
    ldx #0         ; Initialize sum of digits
sumLoop:
    clc            ; Clear carry flag
    lda num        ; Load number to check
    adc #$30       ; Convert ASCII to integer
    bcc endSum     ; If no carry, go to endSum
    adc #$1D       ; Add low value
endSum:
    sta temp       ; Save sum in temporary variable
    cpx temp       ; Compare sum with temp
    bne notHarshad ; If not equal, not Harshad
    lda #$01       ; Else load 1 in A
    sta result     ; Save result in result variable

notHarshad:
    rts            ; Return from subroutine

num:  .byte $34     ; Number to check (ASCII '4')
temp: .byte $00     ; Temporary variable for sum
result: .byte $00   ; Result variable

.end
