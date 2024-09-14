
        .org $8000

radius  .byte $05     ; radius of the cone
height  .byte $0A     ; height of the cone
result  .word $0000   ; variable to store the result

start:
        lda radius      ; load radius into A
        ldx height      ; load height into X

        jsr calculate_volume  ; call the subroutine to calculate the volume

        lda result      ; load the result from memory
        sta $D020        ; store it in a memory location
        
done:
        rts            ; return from subroutine

calculate_volume:
        lda radius      ; load radius into A
        sta $FF         ; store it in zero page memory
        lda height      ; load height into A
        sta $FE         ; store it in zero page memory

        ldx #$03        ; load constant 3 into X
        ldy #$FF        ; load constant -1 into Y

        lda $FF         ; load radius from memory into A
        sta $FD         ; store it in zero page memory

loop:
        clc             ; clear the carry flag
        lda $FD         ; load radius from memory into A
        adc $FD         ; add radius to A
        sta $FD         ; store the result back in memory
        dex             ; decrement X
        bne loop        ; if X is not zero, continue looping

        lda $FD         ; load the final result into A
        sta $FC         ; store it in zero page memory

        lda $FE         ; load height from memory into A
        asl             ; multiply by 2
        asl             ; multiply by 2 again
        asl             ; multiply by 2 a third time
        asl             ; multiply by 2 a fourth time
        sta $FB         ; store the result in zero page memory

        lda $FF         ; load radius from memory into A
        ldx #$02        ; load constant 2 into X

mult_loop:
        clc             ; clear the carry flag
        lda $FC         ; load result into A
        adc $FC         ; add result to A
        sta $FC         ; store the result back in memory
        dex             ; decrement X
        bne mult_loop   ; if X is not zero, continue looping

        lda $FC         ; load the final result into A
        sta result      ; store it in result variable

        lda result
        ldx #$01
        rts

        .end
