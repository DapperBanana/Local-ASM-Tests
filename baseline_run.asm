
        .org $1000
      
start   lda dict_size     ; load the size of the dictionary into accumulator
        sta index         ; store the size of the dictionary in index
    
        ldx #0            ; load 0 into X register to use as index
        lda dict,x       ; load the first value from the dictionary
        sta max_value     ; store the first value as the initial maximum value
        sta min_value     ; store the first value as the initial minimum value
        
loop    inx               ; increment the index
        cmp index         ; compare the index with the size of the dictionary
        beq done          ; if the index equals the size of the dictionary, exit the loop
        
        lda dict,x       ; load the value from the dictionary at the current index
        cmp max_value     ; compare the current value with the maximum value
        bcc not_max       ; if the current value is less than the maximum value, skip to next comparison
        sta max_value     ; store the current value as the new maximum value
        
not_max cmp min_value     ; compare the current value with the minimum value
        bcs not_min       ; if the current value is greater than the minimum value, skip to next comparison
        sta min_value     ; store the current value as the new minimum value
        
        bra loop          ; branch back to the loop
    
done    ; output the maximum and minimum values
        lda max_value
        jsr output_value   ; output the maximum value
        lda min_value
        jsr output_value   ; output the minimum value
        
        rts               ; return from subroutine

output_value
        jsr $fddb          ; output value
        lda #$20
        jsr $ffd2          ; output space
        rts
        
index   .byte 0
max_value .byte 0
min_value .byte 0

dict_size .byte 5
dict    .byte 10, 15, 22, 13, 8
