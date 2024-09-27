
         .org $1000

start    lda #<question
         ldy #>question
         jsr print_string

get_input
         lda #$00
         jsr $ffd2
         cmp #13  ; check if Enter key was pressed
         bne get_input

         lda #$0d
         sta $04
         lda #$00
         sta $05
         lda #$07
         sta $06
         lda #$00
         sta $07

check_answer
         lda #$0d
         sta $05
         lda #$0a
         sta $07
         ldy #0
         lda (4),y
         cmp #<answer
         bne incorrect
         iny
         lda (4),y
         cmp #>answer
         bne incorrect

correct  jsr clear_screen
         lda #<correct_msg
         ldy #>correct_msg
         jsr print_string
         jmp end

incorrect
         jsr clear_screen
         lda #<incorrect_msg
         ldy #>incorrect_msg
         jsr print_string
         jmp end

print_string
         lda (0),y
         beq end
         jsr $ffd2
         iny
         jmp print_string

clear_screen
         lda #$0c
         jsr $ffd2
         lda #$01
         ldx #$00
         sty $07
         jsr $ffd2
         rts

question
         .text "What is the capital of France?"
correct_msg
         .text "Correct! Paris is the capital of France."
incorrect_msg
         .text "Incorrect! The capital of France is Paris."

answer
         .byte "Paris"

end      rts
