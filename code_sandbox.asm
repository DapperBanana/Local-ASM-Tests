
    .org $1000

start:
    lda nums,x    ; load next number from array
    beq end       ; exit loop if number is 0
    cmp prev_num  ; compare with previous number
    beq increment ; if same, increment consecutive count
    lda consecutive_count   ; load consecutive count
    cmp longest_count       ; compare with longest count
    bcs update_longest_count ; if greater, update longest count
    lda #0          ; reset consecutive count
    sta consecutive_count
    lda nums,x     ; load next number
    sta prev_num   ; update previous number
    bra increment  ; branch to increment

increment:
    inx             ; increment index
    lda consecutive_count   ; load consecutive count
    clc
    adc #1          ; increment consecutive count
    sta consecutive_count   ; store updated count
    lda nums,x     ; load next number
    sta prev_num   ; update previous number
    bra start      ; branch to start of loop

update_longest_count:
    lda consecutive_count   ; load consecutive count
    sta longest_count       ; update longest count
    lda #0          ; reset consecutive count
    sta consecutive_count
    bra increment  ; branch to increment

end:
    lda longest_count
    rts

nums:   .byte 2, 3, 3, 4, 5, 5, 5, 0  ; list of integers
prev_num: .byte 0
consecutive_count: .byte 0
longest_count: .byte 0
