
; Recipe Recommendation System

; Define strings for recipes

pasta_recipe:
    .asciiz "Pasta with tomato sauce\n"
pizza_recipe:
    .asciiz "Homemade pizza\n"
salad_recipe:
    .asciiz "Fresh salad with vinaigrette\n"

; Main program

    .org $1000

start:
    lda #0
    sta recipe_type

    ; Display menu
    jsr display_menu

loop:
    lda recipe_type
    cmp #1
    beq pasta_recipe
    cmp #2
    beq pizza_recipe
    cmp #3
    beq salad_recipe

    ; Invalid choice
    jsr invalid_choice
    jmp loop

pasta_recipe:
    jsr print_string
    jmp end

pizza_recipe:
    jsr print_string
    jmp end

salad_recipe:
    jsr print_string
    jmp end

end:
    rts

display_menu:
    lda #0
    jsr print_string
    lda #1
    jsr print_string
    lda #2
    jsr print_string
    lda #3
    jsr print_string
    rts

invalid_choice:
    lda #4
    jsr print_string
    rts

print_string:
    ldx #0

print_loop:
    lda recipe_message, x
    beq print_end
    jsr $ffd2
    inx
    jmp print_loop

print_end:
    rts

recipe_message:
    .byte 0, "Choose a recipe:\n"
    .byte 1, "1. Pasta\n"
    .byte 2, "2. Pizza\n"
    .byte 3, "3. Salad\n"
    .byte 4, "Invalid choice. Please try again.\n"

recipe_type:
    .byte 0

    .end
