
        .org $0200
        
list1   .byte $02, $05, $07, $09, $0A    ; First list
list2   .byte $05, $09, $0B, $0C, $0D    ; Second list
result  .byte $00, $00, $00, $00, $00    ; Result list

start   ldx #0                             ; Initialize index
loop    lda list1,x                        ; Load element from list1
        pha                               ; Save it on stack
        ldy #0                             ; Initialize index for list2
loop2   lda list2,y                        ; Load element from list2
        cmp (result),y                   ; Compare with elements in result list
        beq add_element                    ; If match, add to result list
        iny                               ; Increment index for list2
        cpy #5                             ; Check if reached end of list2
        bne loop2                          ; If not, continue checking
        pla                               ; If no intersection, discard element from list1
        inx                               ; Increment index for list1
        cpx #5                             ; Check if reached end of list1
        bne loop                          ; If not, continue checking
done    rts

add_element
        sta (result),y                   ; Add element to result list
        pla                               ; Discard element from stack
        iny                               ; Increment index for result list
        rts

        .end
