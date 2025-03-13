
; Check if a number is a Lucas-Carmichael number

.segment "CODE"
.org $0200

start:
    ; Input the number to be checked
    lda #0
    sta number+1
    lda #0
    sta number+2
    lda #0
    sta number+3
    lda #29 ; Enter the number to be checked here
    sta number
    
    jsr isLucasCarmichael
    
    ; Output the result
    lda result
    beq notLucasCarmichael
    lda #1
    jsr $FFD2 ; Output the result as "Yes"
    jmp $FFEC ; Halt program
    
notLucasCarmichael:
    lda #0
    jsr $FFD2 ; Output the result as "No"
    
    ; Halt program
    jmp $FFEC

isLucasCarmichael:
    lda number
    sec
    sbc #2
    sta check
    lda number+2
    sbc #1
    
checkNext:
    lda check+1
    lda role1
    sec
    sbc role1+1
    sec
    sbc role2
    jsr divide
    
    lda remainder
    beq checkPrime
    lda number+1
    beq notPrime
    lda number+1
    sec
    sbc #1
    sta number+1
    sec
    sbc #1
    sta number+1
    
    lda check+2
    lsr
    lsr
    lsr
    lsr
    sta check
    
    lda role2
    lsr
    lsr
    lsr
    lsr
    sta role1
    lda role2
    lsr
    lsr
    sta role2
    
    lda number+2
    lsr
    lsr
    lsr
    lsr
    sec
    sbc role1+1
    sec
    sbc role2
    jsr divide
    
    lda quotient
    sta number
    lda remainder
    sta number+1
    lda number+1
    sta number+2
    lda check
    bne checkNext
    
isLucasCarmichaelEnd:
    ldx #0
    ldy #3
    lda number
    lsr
    lsr
    
    ldx #0
    ldy #3
    lda number+1
    lsr
    lsr
    
    lda #0
    sta number+2
    sta number+3
    rts

checkPrime:
    lda remainder
    lda #1
    sta role2
    sta role2+1
    lda role1+1
    dex
    bne notPrime
    sta number+2
    sta number+3
    lda number
    sta number+1
    lda role2
    lda #0
    ldy #0
    bne isLucasCarmichaelEnd
    
notPrime:
    sec
    
role1:
    .byte 0, 0
    
role2:
    .byte 0, 0
    
check:
    .byte 0, 0
    
number:
    .byte 0, 0, 0, 0
    
remainder:
    .byte 0, 0
    
quotient:
    .byte 0, 0
    
result:
    .byte 0
    
; Divide subroutine - Divides A by M and stores the quotient in A and the remainder in M
divide:
    sec
divideLoop:
    sbc role2
    bcc divideEnd
    inc quotient
    jmp divideLoop
divideEnd:
    rts

.segment "DATA"
.org $0300
