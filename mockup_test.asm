
        .org $1000
        
start   lda #10      ; base1 = 10
        sta base1
        
        lda #8       ; base2 = 8
        sta base2
        
        lda #5       ; height = 5
        sta height
        
        ; area = (base1 + base2) * height / 2
        
        lda base1    ; load base1
        clc          ; clear carry
        adc base2    ; add base2
        asl          ; multiply by 2
        sta temp     ; store result in temp
        
        lda height
        adc temp     ; add temp
        asr          ; divide by 2
        sta area
        
        ; output result
        
        lda area     ; load area
        tax          ; transfer to X register for output
        
end     stx $FF00    ; store result in memory location $FF00
        
        rts          ; return from subroutine

base1   .byte 0
base2   .byte 0
height  .byte 0
temp    .byte 0
area    .byte 0
