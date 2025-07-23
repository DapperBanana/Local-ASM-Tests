
ORG $0200

dictValues .byte $10, $20, $30, $40, $50, $60, $70, $80 ; sample dictionary values
dictLen = * - dictValues

; initialize variables
ldx #0            ; start with index 0
ldy dictValues,x  ; get first value
lda dictValues,x
sta maxVal        ; initialize maxVal with first value
sta minVal        ; initialize minVal with first value

loop:
inx               ; move to next element in dictionary
bne checkVal      ; make sure we didn't reach end of dictionary
lda dictValues,x
cmp maxVal        ; compare current value with maxVal
bmi updateMax     ; update maxVal if current value is greater
cmp minVal        ; compare current value with minVal
bpl updateMin     ; update minVal if current value is smaller
jmp loop

checkVal:
cmp dictLen       ; check if we reached end of dictionary
bne loop

done:
rts

updateMax:
sta maxVal
jmp loop

updateMin:
sta minVal
jmp loop

maxVal .byte 0
minVal .byte 0

.END
