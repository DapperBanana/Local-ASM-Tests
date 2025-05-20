
; Harshad (Niven) number checker program in 6502 Assembly

.org $0200

NUM                 .block 1            ; Number to check
RESULT              .block 1            ; Variable to store the result

main:
    lda #0                          ; Initialize sum variable
    ldx #0                          ; Initialize loop index

loop:
    clc                             ; Clear carry
    lda NUM, x                      ; Load the current digit
    cmp #$30                        ; Compare with ASCII code for '0'
    bcc invalidNumber               ; If not a valid digit, exit
    
    sbc #$30                        ; Convert ASCII to binary number
    adc RESULT                      ; Add it to the sum 
    sta RESULT                      ; Store the sum
    
    inx                             ; Increment loop index
    cpx #2                          ; Check if all 2 digits have been processed
    bne loop                        ; If not, continue the loop
    
    ldy RESULT                      ; Load the sum into Y register
    cpy NUM                         ; Compare the sum with the original number
    beq isHarshad                    ; If they are equal, it is a Harshad number
    bne notHarshad                  ; Otherwise, it is not a Harshad number

isHarshad:
    lda #$01                        ; Load 1 to indicate it is a Harshad number
    rts                             ; Return from subroutine

notHarshad:
    lda #$00                        ; Load 0 to indicate it is not a Harshad number
    rts                             ; Return from subroutine

invalidNumber:
    lda #$00                        ; Load 0 to indicate it is not a valid number
    rts                             ; Return from subroutine

.end
