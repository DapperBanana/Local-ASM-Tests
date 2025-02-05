
        .org    $0200
start:
        ldx     #0               ; Initialize index to 0
        lda     dictionary,x     ; Load first value from dictionary
        sta     max_value        ; Initialize max_value with first value
        sta     min_value        ; Initialize min_value with first value

loop:
        inx                     ; Increment index
        cpx     #dictionary_size ; Compare index with size of dictionary
        beq     done            ; If end of dictionary, exit loop

        lda     dictionary,x     ; Load value from dictionary
        cmp     max_value        ; Compare value with current max_value
        bcc     not_max          ; If value smaller, skip updating max_value
        sta     max_value        ; Update max_value
not_max:
        cmp     min_value        ; Compare value with current min_value
        bcs     not_min          ; If value larger, skip updating min_value
        sta     min_value        ; Update min_value
not_min:
        jmp     loop            ; Continue loop

done:
        ; Output max_value and min_value
        ; Your output logic here

dictionary:
        .byte   $10, $20, $30, $40, $50, $60    ; Example dictionary
dictionary_size = * - dictionary

max_value:
        .byte   0
min_value:
        .byte   0

        .end
