
        .org $0200

year    .byte $00

start   lda year        ; Load the year into the accumulator
        tax             ; Transfer the year to the X register
        cmp #$04        ; Check if the year is divisible by 4
        bne not_leap    ; Branch to not_leap if not divisible by 4
        
        cpx #$64        ; Check if the year is divisible by 100
        beq not_leap    ; Branch to not_leap if divisible by 100
        
        cpx #$01        ; Check if the year is divisible by 400
        beq leap        ; Branch to leap if divisible by 400
        
not_leap
        lda #$00        ; Load 0 into the accumulator (not a leap year)
        jmp end         ; Jump to end
        
leap
        lda #$01        ; Load 1 into the accumulator (leap year)
        jmp end         ; Jump to end
        
end
        sta $0201       ; Store the result in memory location $0201
        
        rts             ; Return from subroutine
        
        .org $FFFC
        .word start     ; Set the reset vector to start of program
