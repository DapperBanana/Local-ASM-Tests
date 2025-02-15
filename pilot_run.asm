
; Assume the list of numbers is stored in memory starting at address $2000
; The list is terminated by a byte containing the value $FF
; The program will store the median in memory at address $2001

    lda #$00            ; Initialize counter
    sta $2001           ; Initialize median to 0
    ldx #$2000          ; Initialize index to start of list
loop:
    lda $2000,x         ; Load current number
    cmp #$FF            ; Check if end of list
    beq done            ; If end of list, exit loop
    inx                 ; Increment index
    bmi loop            ; Repeat for negative numbers
    clc                 ; Clear carry flag

count:
    lda $2000,x         ; Load current number
    cmp $2001           ; Compare with current median
    bcc update          ; If less than median, update median
    bcs next            ; If greater than median, skip update

update:
    sta $2001           ; Update median
    bcc next            ; Skip increment if carry flag set
    inc $2001           ; Increment median if not carry flag set

next:
    lda $2000,x         ; Load next number
    cmp #$FF            ; Check if end of list
    bne count           ; Repeat count loop for next number
done:
    rts                 ; Return from subroutine

