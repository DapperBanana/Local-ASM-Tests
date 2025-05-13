
        .org $0200

start   lda #0          ; initialize sum to 0
        sta sum
        ldx #0          ; initialize counter to 0
        sta count
        lda #MESSAGE
        jsr print_string  ; prints user prompt
        jsr get_num       ; get user input for n
        sta n
        
loop    lda count       ; load current counter value
        clc             ; clear carry to add
        adc count       ; add count to accumulator
        sta sum         ; store sum
        inx             ; increment counter
        cpx n           ; compare counter with n
        bcc loop        ; repeat loop if counter < n
        
        lda sum         ; load sum into accumulator
        jsr print_num   ; print the sum
        rts

print_num
        jsr print_space
        jsr convert_num  ; convert accumulator to decimal string
        jsr print_string ; print the decimal string
        rts

print_space
        lda #$20        ; load ASCII space character
        jsr $FFD2       ; CHROUT subroutine
        rts

print_string
        ldx #0
.loop   lda MESSAGE,x   ; load next character from string
        beq .done       ; if end of string, done printing
        jsr $FFD2       ; CHROUT subroutine
        inx             ; increment index
        bne .loop       ; repeat until end of string
.done   rts

convert_num
        ldx #0          ; index for dividing by 10
        sep #$20        ; set decimal mode
.loop   lsr             ; divide accumulator by 2
        rol result      ; shift remainder
        dex             ; decrement index
        cpx #3          ; check if done dividing by 10
        bne .loop       ; repeat until done
        clc             ; clear carry for addition
        lda result,x    ; add remainder to result
        adc #'0'        ; convert to ASCII digit
        sta result,x
        inx             ; increment index
        cpx #3          ; check if done adding remainder
        bne .done       ; repeat until done
        sep #$20        ; set back to binary mode
.done   rts

get_num
        lda #$00        ; clear accumulator
.read   jsr $FFD2       ; CHROUT subroutine
        lda #$00        ; clear accumulator
        jsr $FFCF       ; CHRIN subroutine
        cmp #$0D        ; check if enter key pressed
        beq .done       ; if yes, done reading
        sec             ; set carry for subtraction
        sbc #'0'        ; convert ASCII digit to number
        sta n           ; store number in n
        rts
.done   rts

sum     .byte 0        ; variable to store sum
count   .byte 0        ; variable to store counter
n       .byte 0        ; variable to store n
result  .byte 0,0,0,0  ; array to store converted number
MESSAGE .text "Enter the value of n: "

        .org $FF00
        .word start
