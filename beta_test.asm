
        .org $0200
start   lda num     ; load the number into the accumulator
        and #$01    ; perform bitwise AND operation with 1
        beq even    ; branch if result is zero (even number)
        jmp odd     ; jump to odd subroutine
even    jsr print_even  ; print message for even number
        jmp done    ; jump to end of program
odd     jsr print_odd   ; print message for odd number
done    rts         ; return from subroutine

print_even
        lda #<even_msg  ; load low byte of even message
        ldx #>even_msg  ; load high byte of even message
        jsr $FFD2      ; print message using KERNAL routine
        rts

print_odd
        lda #<odd_msg   ; load low byte of odd message
        ldx #>odd_msg   ; load high byte of odd message
        jsr $FFD2      ; print message using KERNAL routine
        rts

num     .byte 10      ; change this number to test for even/odd

even_msg .text "Number is even$"
odd_msg  .text "Number is odd$"

        .end
