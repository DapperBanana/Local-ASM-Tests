
    .org $0200

start:
    lda list      ; load the first element of the list into A register
    sta current   ; save it as the current value
    lda #1        ; initialize current length as 1
    sta maxLength
    lda #0        ; initialize max length as 0
    sta tempLength
    lda #0        ; initialize temp length as 0
    sta index     ; initialize index as 0
    
next:
    lda index     ; load the index into A register
    cmp #9        ; check if we have reached the end of list
    beq done      ; if so, jump to done
    
    lda list, x   ; load the next element of the list into A register
    cmp current   ; compare it with the current value
    beq increment ; if equal, increment the temp length
    
    lda tempLength ; load the temp length into A register
    cmp maxLength  ; compare it with the max length
    bcc reset      ; if temp length is greater than max length, reset max length
    
increment:
    inx                ; increment the index
    lda tempLength     ; load the temp length into A register
    clc                ; clear carry
    adc #1             ; increment the temp length
    sta tempLength     ; save it
    
    jmp next           ; jump to next element
    
reset:
    lda tempLength     ; load the temp length into A register
    sta maxLength      ; save it as the max length
    lda #0             ; reset the temp length
    sta tempLength
    
    jmp next           ; jump to next element
    
done:
    sta result         ; save the final result in the result variable
    
    ; your code here...
    
    jmp end
    
list:
    .byte 1,1,2,3,4,5,6,7,8,9
    
current:
    .byte $00
    
maxLength:
    .byte $00
    
tempLength:
    .byte $00
    
index:
    .byte $00
    
result:
    .byte $00
    
end:
    .end
