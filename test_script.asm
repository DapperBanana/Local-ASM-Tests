
        .org $0200              ; start address of program
start   lda num+1              ; load MSB of number into A
        sta index              ; store index
        ldx #num               ; load LSB of number into X
        lda #num+num_length-1  ; load length of number
        sta length             ; store length
        ldy #0                 ; initialize index for reverse number
next    lda (index),y          ; load current digit of number into A
        sta temp,y             ; store current digit in temp array
        dey                    ; decrement index
        bpl next               ; loop until end of number
        ldx #num               ; load LSB of number into X
check   lda (length),x         ; load current digit of number into A
        cmp temp,x             ; compare current digit with corresponding digit in temp array
        bne not_palindrome     ; if not equal, jump to not_palindrome
        inx                    ; increment index
        cpx index              ; check if reached halfway point
        bcc check              ; loop until halfway
        lda #$01               ; set flag for palindrome
        rts                    ; return from subroutine
not_palindrome:
        lda #$00               ; clear flag for not palindrome
        rts                    ; return from subroutine

num     .byte $12,$34,$56,$34,$12   ; example number
num_length = *-num

index   .byte 0                  ; index for current digit
temp    .ds num_length           ; temporary array to store reversed number
length  .byte 0                  ; length of number
