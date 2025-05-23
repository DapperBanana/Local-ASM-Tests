
    .org $0200

start:
    ; Reset vectors
    sei
    cld
    ldx #$FF
    txs
    stx $4017
    stx $4000
    stx $4001
    stx $4002
    stx $4003
    stx $4007

    lda #$01
    sta $4015

    lda #$40
    sta $4010
    lda #$00
    sta $4015

    ; Start of Program
    lda #<question1
    sta $0200
    lda #>question1
    sta $0201

    ldx #0
    lda #6
    sta $0202   ; number of questions
    lda #$00
    sta $0203   ; answer counter

ask_question:
    lda $0203
    cmp $0202
    beq show_result

    lda #$00
    sta $0204   ; selected answer
    lda $0200
    jsr print_string

input_answer:
    jsr read_key
    cmp #1
    beq select_answer1
    cmp #2
    beq select_answer2
    cmp #3
    beq select_answer3
    bne input_answer

select_answer1:
    lda #1
    sta $0204
    b answer_selected

select_answer2:
    lda #2
    sta $0204
    b answer_selected

select_answer3:
    lda #3
    sta $0204
    b answer_selected

answer_selected:
    lda $0204
    clc
    adc $0203
    sta $0203

    lda $0203
    jsr print_newline

    inc $0200
    inc $0200
    bra ask_question

show_result:
    lda $0203
    jsr print_newline

    lda #$00
    jsr print_string
    lda #$01
    jsr print_string
    lda #$02
    jsr print_string

    ; Infinite loop
inf_loop:
    jmp inf_loop

print_string:
    ldy #0
print_loop:
    lda ($0200), y
    beq print_end
    jsr print_char
    iny
    bne print_loop

print_end:
    rts

print_char:
    sta $0205
    lda #$00
    sta $0206
    lda #$02
    sta $0207
    lda #$01
    sta $0208
    lda $0205
    jsr $FFD2
    rts

print_newline:
    lda #$0D
    jsr print_char
    lda #$0A
    jsr print_char
    rts

read_key:
    lda #$08
    sta $0209
key_loop:
    lda $0209
    cmp #$08
    beq key_loop
    lda $4016
    and #$01
    beq key_loop
    lda $4016
    rts

question1:
    .text "Question 1: What is your favorite color?"
    lda #1
    jsr print_string
    lda #2
    jsr print_string
    lda #3
    jsr print_string
    .byte $00

question2:
    .text "Question 2: What is your favorite animal?"
    lda #1
    jsr print_string
    lda #2
    jsr print_string
    lda #3
    jsr print_string
    .byte $00

; Add more questions as needed

    .end
