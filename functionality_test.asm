
    lda #0             ; initialize index
    sta index
    
loop:
    lda list, x        ; load element of list at index x
    sta temp           ; store element in temp
    
    ; calculate square of element
    lda temp
    clc
    adc temp
    sta result+1       ; store high byte of result
    lda #0
    adc temp
    sta result         ; store low byte of result
    
    ; store result in output list
    sta output, x
    
    inx                ; increment index
    cpx #length        ; check if end of list
    bcs done
    
    jmp loop
    
done:
    rts
    
index:
    .byte 0
    
temp:
    .byte 0
    
result:
    .word 0
    
list:
    .byte 2, 4, 6, 8   ; input list
    length = * - list
    
output:
    .byte 0, 0, 0, 0   ; output list
