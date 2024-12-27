
        .org $0600

start   lda #<welcome_message
        sta $FFFC
        lda #>welcome_message
        sta $FFFD

        jsr output_message

        lda #<choose_destination_message
        sta $FFFC
        lda #>choose_destination_message
        sta $FFFD

        jsr output_message
        jsr get_user_input

        lda user_input
        cmp #$01
        beq planet1
        cmp #$02
        beq planet2
        cmp #$03
        beq planet3
        cmp #$04
        beq planet4

invalid_input
        lda #<invalid_input_message
        sta $FFFC
        lda #>invalid_input_message
        sta $FFFD

        jsr output_message
        lda #<try_again_message
        sta $FFFC
        lda #>try_again_message
        sta $FFFD

        jsr output_message
        jsr get_user_input
        jmp start

planet1 lda #<planet1_message
        sta $FFFC
        lda #>planet1_message
        sta $FFFD

        jsr output_message
        rts

planet2 lda #<planet2_message
        sta $FFFC
        lda #>planet2_message
        sta $FFFD

        jsr output_message
        rts

planet3 lda #<planet3_message
        sta $FFFC
        lda #>planet3_message
        sta $FFFD

        jsr output_message
        rts

planet4 lda #<planet4_message
        sta $FFFC
        lda #>planet4_message
        sta $FFFD

        jsr output_message
        rts

output_message
        ldx #$00
output_loop
        lda (FFFC),x
        beq output_done
        jsr $FFD2
        inx
        bne output_loop

output_done
        rts

get_user_input
        lda #$00
        jsr $FFCF
        sta user_input
        rts

welcome_message   .byte "Welcome to Space Explorer!", $00
choose_destination_message .byte "Choose your destination: 1. Planet 1 2. Planet 2 3. Planet 3 4. Planet 4", $00
planet1_message   .byte "You have arrived at Planet 1. Welcome!", $00
planet2_message   .byte "You have arrived at Planet 2. Welcome!", $00
planet3_message   .byte "You have arrived at Planet 3. Welcome!", $00
planet4_message   .byte "You have arrived at Planet 4. Welcome!", $00
invalid_input_message .byte "Invalid input. Please try again.", $00
try_again_message .byte "Choose your destination: 1. Planet 1 2. Planet 2 3. Planet 3 4. Planet 4", $00

user_input  .byte $00

        .end
