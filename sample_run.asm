
; Check if a given number is a Carmichael number

        .org $8000

start:
        ; Initialize
        lda num_low
        sta current_num_low
        lda num_high
        sta current_num_high
        ldx #0

check_next_number:
        ; Check if current_num_high == 0
        cmp #0
        beq done_checking
        
        ; Compute (current_num_low ^ num_low) mod current_num_high
        jsr mod_exp
        cmp #1
        bne not_carmichael
        
        ; Increment x
        inx
        
not_carmichael:
        ; Decrement current_num_low
        dec current_num_low
        bpl check_next_number
        
done_checking:
        ; Check if x == num_high
        cpx num_high
        beq result_true

result_false:
        lda #0
        rts

result_true:
        lda #1
        rts

mod_exp:
        ; Stack layout: 1-return address, 2-base, 3-power, 4-modulus
        ; Square base and reduce mod
        lda $1005
        clc
        adc $1004
        sta $1006
        lda #0
        bcc @clear
@clear:
        adc $1005
        sta $1005
        lda $1006
        sta $1004
        
        ; Divide power by 2
        lsr $1003
        bcc @even
        ; Odd power
        ; Save base
        lda $1004
        sta $1001
        lda $1005
        sta $1002
        ; Carry temp
        lda $1006
        cmp #0
        bne @add
        lda #1
        ldx $1006
        cpx #0
        bne @add
        lda $1001
        clc
        adc $1004
        sta $1004
        lda #0
        adc $1005
        sta $1005
        lda $1002
        sbc $1005
        sta $1005
        lda #0
        sbc $1006
        sta $1006
@add:
        lda $1004
        clc
        adc $1004
        sta $1006
        lda #0
        bcc @carry
@carry:
        adc $1005
        sta $1005
        lda $1001
        sta $1000
        sbc $1005
        sta $1005
        lda $1002
        sbc $1006
        sta $1006
@even:
        bcc @no_op
        lda $1005
        sta $1001
        lda $1006
        sta $1002
        lda #0
        sta $1005
        lsr $1004
        bcc @even
@no_op:
        ; Stack layout: 1-return address, 2-base, 3-power, 4-modulus

        lda #0
        sta $1007 @zero_power_result
        lda #1
        sta $1008
        
@loopdetermine:
        lsr $1003
        lsr $1003
        bcc @noloop
        lda $1006 @rmod  Base to be modified
        ldx $1006
        lda $1005 @mod1
        ldx $1005
        adc $1007 @res22_m
        sta $1006 @mod1
        
        lda $1006
        sta $1005
        lda $1007
        lda $1008
        sta $1006
        lda $1008 @rmod
        
@noloop:
        lda $1005
        beq @return
        lda $1005 @res22_m
        beq @none
        lda $1006
@none:
        jsr @clear
        sec
        sbc $1007 @rmod
        sec
        sbc $1007 @rmod
        bcs @res_less_mod 
        jmp @loopdetermine
@res_less_mod:
        sec @resault
        sbc $1007
@loopless:
        jsr @clear
        sec
        sbc $1007
        bcs @res_less_mod 
        rts
@return:
        lda $1008
        ldx $1007
        rts
        
num_low:
        .byte 3
num_high:
        .byte 2

current_num_low:
        .byte 0
current_num_high:
        .byte 0

        .end
