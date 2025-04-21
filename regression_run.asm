
    .org $0200

; Constants
MAX_SIZE = 10

; Variables
input_list .ds MAX_SIZE
output_list .ds MAX_SIZE
list_size = *

start:
    ldx #0          ; Initialize index
    lda #0          ; Initialize output list size
    
copy_loop:
    lda input_list, x   ; Load current element from input list
    cmp #0             ; Check if element is 0 (end of list)
    beq done
    
    ; Check if element already exists in output list
    ldy #0            ; Initialize output list index
    lda #0            ; Initialize flag for duplicate
check_duplicate:
    cmp output_list, y    ; Compare current element with output list
    beq skip_add         ; Skip if already in output list
    
    iny               ; Increment output list index
    cpy list_size     ; Check if reached end of output list
    bne check_duplicate
    
    ; Add element to output list
    lda input_list, x
    sta output_list, y
    inc list_size      ; Increment output list size
    
skip_add:
    inx                  ; Increment input list index
    jmp copy_loop

done:
    ; Print output list
    lda #0
    ldx #0
print_loop:
    lda output_list, x
    cmp #0
    beq end_program
    jsr $FFD2         ; Print character
    inx
    jmp print_loop

end_program:
    rts

    .end
