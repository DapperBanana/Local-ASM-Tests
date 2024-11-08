
        .org $c000

dict    .byte $05, $0A, $04, $12, $08
size    .byte $05

max_val .byte 0
min_val .byte 0

start   
        ldx #0              ; Initialize index to 0
        lda dict,x          ; Load first element of dictionary
        sta max_val         ; Set it as initial max value
        sta min_val         ; Set it as initial min value

loop    
        inx                 ; Increment index
        cpx size            ; Compare index with dictionary size
        beq done            ; If end of dictionary, go to done
        lda dict,x          ; Load next element of dictionary

        cmp max_val         ; Compare with current max value
        bcc update_min      ; If value < min_val, update min_val
        bcs update_max      ; If value > max_val, update max_val

update_min
        sta min_val         ; Update min value
        bra loop

update_max
        sta max_val         ; Update max value
        bra loop

done    
        halt

        .end
