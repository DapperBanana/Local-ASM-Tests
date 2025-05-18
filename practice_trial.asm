
        .org $0200

start   lda #0        ; Initialize score to 0
        sta score

        ; Question 1
        lda #<question1 ; Load low byte of question1 address
        sta $fb         ; Store low byte in zero page address $fb
        lda #>question1 ; Load high byte of question1 address
        sta $fc         ; Store high byte in zero page address $fc
        jsr print_question

        ; Display answer choices
        lda #<choice1   ; Load low byte of choice1 address
        sta $fb         ; Store low byte in zero page address $fb
        lda #>choice1   ; Load high byte of choice1 address
        sta $fc         ; Store high byte in zero page address $fc
        jsr print_answer

        ; User input
        jsr get_input
        cmp #1          ; Check if user input matches correct answer
        beq correct     ; Branch if correct

        ; Question 2
        lda #<question2
        sta $fb
        lda #>question2
        sta $fc
        jsr print_question

        lda #<choice2
        sta $fb
        lda #>choice2
        sta $fc
        jsr print_answer

        jsr get_input
        cmp #2
        beq correct

        ; Display final score
        lda score
        jsr print_score

        rts

correct lda score      ; Increment score for correct answer
        clc
        adc #1
        sta score
        rts

print_question
        lda $fb
        ldy $fc
loop    lda (indirect),y ; Load next character
        beq end_loop      ; Branch if end of string
        jsr $ffd2         ; Print character to screen
        iny
        jmp loop
end_loop
        rts

print_answer
        lda $fb
        ldy $fc
loop    lda (indirect),y
        beq end_loop
        jsr $ffd2
        iny
        jmp loop
end_loop
        cmp #0
        beq return
        lda #" "
        jsr $ffd2
        jmp print_answer
return  rts

print_score
        lda #"Score: "
        jsr $ffd2
        lda score
        jsr $ffd2
        lda #" / 2"
        jsr $ffd2
        rts

get_input
        jsr $ffd0     ; Get user input
        cmp #"0"
        bcs invalid_input
        cmp #"3"
        bcc valid_input
invalid_input
        lda #"Please enter a valid choice (1-2): "
        jsr $ffd2
        jmp get_input
valid_input
        jsr $ffd2     ; Print user input
        rts

question1
        .text "What is the capital of France? 1. Berlin 2. Paris"

question2
        .text "Which planet is closest to the sun? 1. Mars 2. Mercury"

choice1
        .byte "1. Berlin "
        .byte "2. Paris"
        .byte 0

choice2
        .byte "1. Mars   "
        .byte "2. Mercury"
        .byte 0

score   .byte 0

        .end
