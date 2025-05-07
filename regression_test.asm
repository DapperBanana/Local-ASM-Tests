
    .equ    side_a, $00     ; Define memory location for side_a
    .equ    side_b, $01     ; Define memory location for side_b
    .equ    side_c, $02     ; Define memory location for side_c
    .equ    base, $03       ; Define memory location for base
    .equ    height, $04     ; Define memory location for height
    
    .org    $200           ; Set origin address

start:
    lda     #10            ; Load side_a value
    sta     side_a         ; Store side_a value
    
    lda     #12            ; Load side_b value
    sta     side_b         ; Store side_b value

    lda     #15            ; Load side_c value
    sta     side_c         ; Store side_c value
    
    jsr     calc_base      ; Calculate the base of the triangle
    jsr     calc_height    ; Calculate the height of the triangle
    jsr     calc_area      ; Calculate the area of the triangle
    
    jmp     $FFFE          ; End program

calc_base:
    lda     side_a         ; Load side_a value
    clc
    adc     side_b         ; Add side_b value
    adc     side_c         ; Add side_c value
    sta     base           ; Store the result as the base
    rts

calc_height:
    lda     base           ; Load base value
    sta     $FD            ; Store base value temporarily
    lda     side_a         ; Load side_a value
    sec
    sbc     side_b         ; Subtract side_b value
    sbc     side_c         ; Subtract side_c value
    asl                   ; Multiply by 2 to get height
    sta     height         ; Store the result as the height
    lda     $FD            ; Restore base value
    sta     base           ; Store the base back
    rts

calc_area:
    lda     base           ; Load base value
    lda     height         ; Load height value
    jsr     multiply       ; Multiply the base and height to get area
    rts

multiply:
    clc
    adc     #$0000, x      ; Clear accumulator and index register
    sta     $FD            ; Store the result temporarily
    lda     base           ; Load base value
    clc
    adc     height         ; Add height value
    sta     $FE            ; Store the result temporarily
    lda     $FD            ; Restore previous result
    adc     $FE            ; Multiply the values
    sta     $FF            ; Store the result as the area
    rts
