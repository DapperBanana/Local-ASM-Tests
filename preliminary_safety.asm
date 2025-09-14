
    ; Quiz Program
    
    .org $0200
    
loop:
    lda #0              ; Clear accumulator
    jsr $FFD2           ; Print question
    jsr $FFD0           ; Get user input
    
    cmp #$31            ; Check if user input is correct
    beq correct_answer
    
    jmp wrong_answer
    
correct_answer:
    jsr $FFD2           ; Print correct message
    jmp loop
    
wrong_answer:
    jsr $FFD3           ; Print wrong message
    jmp loop
    
questions:
    .asciiz "What is the capital of France? A) Paris B) Madrid C) Rome\n"
    .asciiz "What is the largest planet in our solar system? A) Earth B) Jupiter C) Mars\n"
    .asciiz "Who wrote 'Romeo and Juliet'? A) Charles Dickens B) William Shakespeare C) Jane Austen\n"
    
    .org $FFD0
    .text "Enter your answer: "
    
    .org $FFD2
    .text "Correct!\n"
    
    .org $FFD3
    .text "Wrong answer. Try again.\n"
