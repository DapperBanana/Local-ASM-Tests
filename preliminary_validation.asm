
        .org $0200

start   ldx #0              ; Initialize index
        lda #0              ; Set first Fibonacci number to 0
        sta $00             ; Store first Fibonacci number
        inx                 ; Increment index
        lda #1              ; Set second Fibonacci number to 1
        sta $01             ; Store second Fibonacci number

fibloop cmpx #10            ; Compare index to 10
        bcs done            ; If index is greater than 10, exit loop
        lda $00             ; Load first Fibonacci number
        clc
        adc $01             ; Add second Fibonacci number
        sta $02             ; Store sum in memory
        sta $00             ; Swap values for next iteration
        lda $01
        sta $01
        lda $02             ; Load sum of previous two numbers
        jsr print_fib       ; Print Fibonacci number
        inx                 ; Increment index
        bra fibloop

done    rts

print_fib
        ; Code to print Fibonacci number (Assuming $FFD2 is used to print byte on screen)
        ; For simplicity, this program assumes that Fibonacci numbers will not exceed 255
        sta $03             ; Store Fibonacci number to print
        ldx $03
        jsr $FFD2           ; Print Fibonacci number
        lda #' '            ; Print space for better readability
        jsr $FFD2
        rts

        .end
