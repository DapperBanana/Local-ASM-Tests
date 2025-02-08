
    .text
    .org $0600

start:
    lda #0
    sta $A000    ; Clear screen
    lda #<welcome
    sta $A000    ; Print welcome message
    lda #>welcome
    sta $A000
    lda #<newline
    sta $A000
    lda #>newline
    sta $A000

    lda #<options
    sta $A000    ; Print movie options
    lda #>options
    sta $A000
    lda #<newline
    sta $A000
    lda #>newline
    sta $A000

    lda #<input_prompt
    sta $A000    ; Print input prompt
    lda #>input_prompt
    sta $A000

loop:
    lda $A000    ; Wait for input
    cmp #13      ; Check for enter key press
    bne loop

    lda $A001    ; Read user input
    cmp #1       ; Check for option 1
    beq recommend1
    cmp #2       ; Check for option 2
    beq recommend2
    cmp #3       ; Check for option 3
    beq recommend3

    lda #<invalid
    sta $A000    ; Display error message for invalid input
    lda #>invalid
    sta $A000
    lda #<newline
    sta $A000
    lda #>newline
    sta $A000
    jmp loop

recommend1:
    lda #<recommendation1
    sta $A000    ; Display recommendation 1
    lda #>recommendation1
    sta $A000
    jmp end

recommend2:
    lda #<recommendation2
    sta $A000    ; Display recommendation 2
    lda #>recommendation2
    sta $A000
    jmp end

recommend3:
    lda #<recommendation3
    sta $A000    ; Display recommendation 3
    lda #>recommendation3
    sta $A000

end:
    lda #<end_message
    sta $A000    ; Display end message
    lda #>end_message
    sta $A000

    rts

welcome: .text "Welcome to the movie recommendation system!"
options: .text "Please choose from the following options:"
input_prompt: .text "Enter the number of the movie you would like a recommendation for:"
invalid: .text "Invalid input. Please try again."
newline: .byte 13, 10, 0
recommendation1: .text "Recommendation 1: Movie A"
recommendation2: .text "Recommendation 2: Movie B"
recommendation3: .text "Recommendation 3: Movie C"
end_message: .text "Thank you for using the movie recommendation system!"

    .end
