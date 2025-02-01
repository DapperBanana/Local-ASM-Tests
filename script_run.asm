
        .org $1000

main    lda #<intro
        sta $2000
        lda #>intro
        sta $2001
        jsr print_string
        jsr get_input
        
        lda #<recommendation
        sta $2000
        lda #>recommendation
        sta $2001
        jsr print_string

        lda $2002
        cmp #$20
        beq end
        
        lda $2002
        cmp #$59
        beq comedy
        cmp #$53
        beq horror
        cmp #$41
        beq action
        cmp #$44
        beq drama
        
        lda #<no_recommendation
        sta $2000
        lda #>no_recommendation
        sta $2001
        jsr print_string
        jmp main
        
comedy  lda #<comedy_recommendation
        sta $2000
        lda #>comedy_recommendation
        sta $2001
        jsr print_string
        jmp main
        
horror  lda #<horror_recommendation
        sta $2000
        lda #>horror_recommendation
        sta $2001
        jsr print_string
        jmp main

action  lda #<action_recommendation
        sta $2000
        lda #>action_recommendation
        sta $2001
        jsr print_string
        jmp main

drama   lda #<drama_recommendation
        sta $2000
        lda #>drama_recommendation
        sta $2001
        jsr print_string
        jmp main

print_string
        ldx #0
loop    lda ($2000),x
        beq end_string
        jsr $ffd2
        inx
        jmp loop

end_string
        rts

get_input
        lda #$FF
        sta $2002
        lda #$00
        sta $2002
        lda #<input
        sta $2000
        lda #>input
        sta $2001
        jsr print_string
        lda #$00
wait    lda $2002
        cmp #$FF
        beq wait
        rts
        
intro   .text "Welcome to the movie recommendation system! Please enter a genre (comedy, horror, action, drama): "
recommendation  .text "Based on your preference, I recommend you watch: "
no_recommendation .text "No recommendation at this time."
comedy_recommendation .text "For comedy lovers, I recommend: Airplane!"
horror_recommendation .text "For horror fans, I recommend: The Shining!"
action_recommendation .text "For action enthusiasts, I recommend: Die Hard!"
drama_recommendation .text "For drama lovers, I recommend: The Shawshank Redemption!"
input   .byte 0

        .end
