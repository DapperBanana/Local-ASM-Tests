
; Program to convert a decimal number to a binary number

        .org $6000  ; Start program at memory location $6000

start   lda #10     ; Load decimal number to convert
        sta decNum  ; Store in memory
        ldx #7      ; Initialize counter for binary digits
        
convert lda decNum  ; Load decimal number
        lsr         ; Shift right to divide by 2
        bcc skip    ; Skip next instruction if carry flag is clear
        ora #$80    ; Set bit 7 for binary digit
skip    dex         ; Decrement counter
        bpl convert ; Repeat until all digits converted
        
        sta binNum  ; Store result in memory
        hlt         ; Halt program

decNum  .byte 0     ; Decimal number to convert
binNum  .byte 0     ; Binary result

        .end        ; End of program
