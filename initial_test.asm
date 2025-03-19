
; Area of a Trapezoid Calculator

.area   equ     $0000           ; Base of the trapezoid
.height equ     $0001           ; Height of the trapezoid
.top    equ     $0002           ; Top base of the trapezoid
.result equ     $0003           ; Result of the area calculation

        processor 6502
        org $0200

start   lda #10
        sta area
        lda #6
        sta height
        lda #5
        sta top

        lda area            ; Load the base of the trapezoid
        clc
        adc top             ; Add the top base of the trapezoid
        lsr
        sta result          ; Store the average of the two bases in result
        lda result
        adc result          ; Multiply the average by the height
        clc 
        adc height
        sta result          ; Store the result in output

loop    jmp loop

        end start
