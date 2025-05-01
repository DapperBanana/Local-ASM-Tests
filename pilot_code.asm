
        .org $0200

pet_name    .byte "Nemo",0
happiness   .byte 50
hunger      .byte 50

start:
        lda #<pet_name
        sta $00
        lda #>pet_name
        sta $01

main:
        ; prompt user for input
        lda #<message
        sta $02
        lda #>message
        sta $03
        jsr print_message

        ; read user input
        jsr read_input

        ; process input
        cmp #1        ; feed
        beq feed
        cmp #2        ; play
        beq play
        cmp #3        ; quit
        beq quit

        ; update pet's happiness and hunger levels
        lda hunger
        clc
        adc #5
        cmp #100
        bcc update_hunger
        lda #100
update_hunger:
        sta hunger

        lda happiness
        clc
        adc #5
        cmp #100
        bcc update_happiness
        lda #100
update_happiness:
        sta happiness

        jmp main

feed:
        lda hunger
        sec
        sbc #10
        bpl update_hunger

        lda #0
        sta hunger
        jmp main

play:
        lda happiness
        sec
        sbc #10
        bpl update_happiness

        lda #0
        sta happiness
        jmp main

quit:
        rts

message: 
        .byte "1. Feed pet", 13, 10, "2. Play with pet", 13, 10, "3. Quit", 13, 10, 0

print_message:
        lda $02
        beq end_print_message
        jsr $ffd2
        jsr print_message
        
end_print_message:
        rts

read_input:
        jsr $ffce
        cmp #13   ; check for return key
        bne end_read_input
        lda $d012
        bpl read_input
        rts
end_read_input:
        rts

        .end
