
    .org $0200

start:
    lda #0         ; Initializing accumulator
    sta result     ; Initializing result variable
    ldx #2         ; Initializing divisor
    
input:
    lda $0201      ; Load input number from memory
    cmp #0         ; Compare input number with 0
    beq end        ; If input number is 0, exit program
    
    cpx $0201      ; Compare divisor with input number
    beq input      ; If divisor equals input number, go back to input
    
    jsr mod        ; Call subroutine to check modulus
    cmp #1         ; Compare result with 1
    bne not_carmichael ; If result is not 1, input is not a Carmichael number
    
    inx            ; Increment divisor
    jmp input      ; Go back to input
    
not_carmichael:
    lda #0         ; Set result to 0
    sta result
    
end:
    sta $0202      ; Store result in memory
    rts            ; Return from subroutine

mod:
    lda $0201
    cmp $0201
    bne check_mod
    sta temp
    jsr pow
    lda temp       ; Load original divisor
    ldx $0201      ; Load input number
    jsr mod_check
    rts

check_mod:
    sta div
    jsr pow
    lda div        ; Load original divisor
    ldx $0201      ; Load input number
    jsr mod_check
    rts

pow:
    lda #1         ; Initialize power to 1
    sta power
    
pow_loop:
    ldx $0201
    dex            ; Decrement divisor
    bne pow_squaring
    
    rts
    
pow_squaring:
    lda power
    lsr            ; Divide power by 2
    sta power
    
    lda $0202
    jsr multiply   ; Multiply accumulator by input number
    sta $0202
    
    jsr mod_check  ; Check if result is greater than input number
    
    lda power
    and #1         ; Check if power is odd
    bne not_odd     ; If power is not odd, continue squaring
    lda $0202
    jsr multiply   ; Multiply accumulator by original number
    sta $0202
    jsr mod_check  ; Check if result is greater than input number

not_odd:
    jmp pow_loop   ; Go back to squaring

multiply:
    asl            ; Multiply accumulator by 2
    sec
    sbc $0202      ; Subtract input number from accumulator
    bcc multiply   ; If carry clear, continue multiplication
    clc
    adc $0201       ; Add input number to accumulator
    
mod_check:
    cmp $0201      ; Compare result with input number
    bcc skip_mod_check ; If result is less than input number, skip check
    sec
    sbc $0201      ; Subtract input number from result
    bcs mod_check  ; If carry set, continue subtracting
    
    rts            ; Return from subroutine

skip_mod_check:
    rts

result:
    .byte 0
div:
    .byte 0
power:
    .byte 0
temp:
    .byte 0

    .end
