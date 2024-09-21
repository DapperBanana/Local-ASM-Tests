
    .org $0200

start:
    ; Question 1
    lda #1
    jsr print_question
    jsr print_option_a
    jsr print_option_b
    jsr print_option_c
    jsr get_input
    cmp #1
    beq correct_answer

    ; Question 2
    lda #2
    jsr print_question
    jsr print_option_a
    jsr print_option_b
    jsr print_option_c
    jsr get_input
    cmp #3
    bne incorrect_answer

correct_answer:
    jsr print_correct
    jmp start

incorrect_answer:
    jsr print_incorrect
    jmp start

print_question:
    lda #$0A
    jsr $FFD2
    rts

print_option_a:
    lda #"A"
    jsr $FFD2
    lda #"." 
    jsr $FFD2
    lda #" Option A: What is the capital of France?"
    jsr $FFD2
    lda #$0A
    jsr $FFD2
    rts

print_option_b:
    lda #"B"
    jsr $FFD2
    lda #"." 
    jsr $FFD2
    lda #" Option B: What is the capital of Germany?"
    jsr $FFD2
    lda #$0A
    jsr $FFD2
    rts

print_option_c:
    lda #"C"
    jsr $FFD2
    lda #"." 
    jsr $FFD2
    lda #" Option C: What is the capital of Italy?"
    jsr $FFD2
    lda #$0A
    jsr $FFD2
    rts

print_correct:
    lda #"Correct!"
    jsr $FFD2
    lda #$0A
    jsr $FFD2
    rts

print_incorrect:
    lda #"Incorrect!"
    jsr $FFD2
    lda #$0A
    jsr $FFD2
    rts

get_input:
    lda #"Answer: "
    jsr $FFD2
    lda #$0D
    jsr $FFD2
    lda $FF00
    jsr $FFD2
    lda #$0A
    jsr $FFD2
    rts
