
        .org $0200

start   lda #NUMBER          ; Load the number to be factored
        sta number

        lda #$00
        sta factor          ; Initialize the factor counter

        lda #$02
        sta divisor         ; Start with divisor = 2

loop    lda number
        cmp #$01            ; Check if number is 1
        beq end

        lda number
        cmp divisor         ; Check if number is divisible by divisor
        bcc incr_divisor

        lda divisor
        clc
        adc #$01            ; Increment divisor
        sta divisor
        bcs incr_divisor    ; Check for overflow

        bra loop

incr_divisor
        lda divisor
        tay
        lda number
        lsr                 ; Divide number by divisor
        bcc check_factor

rem_loop
        clc
        adc divisor
        bcs rem_loop

        sta number
        lda divisor
        jsr print_factor    ; Print out the factor
        bra loop

check_factor
        lda number
        cmp #$01
        bne loop

end     rts

print_factor
        tax
        ldx factor
        sta factors, x
        inx
        dex
        stx factor

        lda #'0'
        jsr print_char
        lda factors, x
        jsr print_char

        lda #' '
        jsr print_char

        rts

print_char
        jsr $ffd2           ; Output the character
        rts

NUMBER  = $0A
number  .byt $00
factor  .byt $00
divisor .byt $02
factors .res $08

        .end
