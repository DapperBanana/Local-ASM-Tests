
; Initialize two sorted lists
list1:   .byte 2, 4, 6, 8, 10
list2:   .byte 1, 3, 5, 7, 9

; Initialize variables
index1:  .byte 0
index2:  .byte 0
merged:  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

; Entry point
        lda #0
        sta index1
        lda #0
        sta index2
        lda #0
        sta index3
        jsr mergeLists

        ; Exit program
        rts

mergeLists:
    lda index1
    clc
    adc index2
    tax
    lda #0
    sta index3
    lda #0
    ldx #0

mergeLoop:
    lda list1, x
    cmp list2, x
    bcc copyList1
    bcs copyList2

copyList1:
    lda list1, x
    sta merged, x
    inx
    inc index1
    jmp checkEnd

copyList2:
    lda list2, x
    sta merged, x
    inx
    inc index2

checkEnd:
    cpx #5
    beq endMerge
    jmp mergeLoop

endMerge:
    rts
