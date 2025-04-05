
; Constants
LIST1_START = $1000
LIST2_START = $2000
MERGED_START = $3000

; Program entry point
    .org $8000
    lda #<LIST1_START
    sta ptr1
    lda #>LIST1_START
    sta ptr1+1
    
    lda #<LIST2_START
    sta ptr2
    lda #>LIST2_START
    sta ptr2+1

    lda #<MERGED_START
    sta merged_ptr
    lda #>MERGED_START
    sta merged_ptr+1

; Merging the lists
merge_lists:
    lda (ptr1),y
    sta temp1
    
    lda (ptr2),y
    sta temp2
    
    cmp temp1,temp2
    bcc add_temp1
    
add_temp2:
    sta (merged_ptr),y
    iny
    dec temp2
    bne merge_lists
    
add_temp1:
    sta (merged_ptr),y
    iny
    dec temp1
    bne merge_lists
    
    jmp next

next:
    lda temp1
    cmp #0
    beq end
    
    lda (ptr1),y
    sta (merged_ptr),y
    iny
    dec temp1
    bne next
    
end:
    lda temp2
    cmp #0
    beq finalize
    
    lda (ptr2),y
    sta (merged_ptr),y
    iny
    dec temp2
    bne end

finalize:
    rts

; Variables
ptr1:    .word 0
ptr2:    .word 0
merged_ptr: .word 0
temp1:  .byte 0
temp2:  .byte 0

