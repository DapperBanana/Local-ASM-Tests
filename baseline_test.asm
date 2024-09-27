
        .segment "CODE"
        .org $0200

start   ldx #0               ; Initialize index
        lda numbers,x        ; Load first number
        sta result           ; Store it as the initial result
        
next    inx                  ; Increment index
        cpx #3               ; Check if all numbers have been processed
        beq done             ; If yes, exit
        
        lda result           ; Load current result
        clc
        adc numbers,x        ; Add the next number
        jsr gcd              ; Calculate GCD
        lda result
        sec
        sbc gcd_result       ; Subtract GCD from the product of the two numbers
        adc numbers,x        ; Add the next number
        tax                  ; Store it in X for the next loop
        sta result
        jmp next             ; Repeat for the next number

done    rts

gcd     lda result           ; Load result
        sta temp             ; Store it temporarily
loop    ldx #0               ; Initialize index
        lda gcd_result       ; Load GCD result
        cmp temp             ; Compare with temp
        beq done_gcd         ; If they are equal, exit
        ldx #0               ; Initialize index for the next loop
        lda temp             ; Load temp
        SEC
        SBC gcd_result       ; Subtract GCD from the temp
        sta temp             ; Store the new result
        ldx #0               ; Initialize index for the next loop
        jmp loop             ; Repeat

done_gcd
        rts

        .segment "DATA"
numbers .byte 3, 4, 6          ; List of numbers to find LCM
result  .word 0                ; Variable to store the result
gcd_result .word 0             ; Variable to store the GCD
temp    .word 0               ; Temporary variable to store interim results
