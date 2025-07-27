
 ; Text-based recipe recommendation system

 .org $0200

 ; Recipe data
recipe_1:
    .byte "Spaghetti and Meatballs", 0
    .byte "Spaghetti", 0
    .byte "Meatballs", 0

recipe_2:
    .byte "Chicken Parmesan", 0
    .byte "Chicken", 0
    .byte "Tomato Sauce", 0
    .byte "Cheese", 0

recipe_3:
    .byte "Vegetable Stir-fry", 0
    .byte "Mixed Vegetables", 0
    .byte "Soy Sauce", 0
    .byte "Rice", 0

menu:
    .byte "1. Spaghetti and Meatballs", 0
    .byte "2. Chicken Parmesan", 0
    .byte "3. Vegetable Stir-fry", 0
    .byte "Please select a recipe (1-3): ", 0

choice:
    .byte 0

start:
    lda #<menu
    ldx #>menu
    jsr print_string

    lda #1
    jsr read_char
    sta choice

    cmp #49
    beq recipe_1_selected
    cmp #50
    beq recipe_2_selected
    cmp #51
    beq recipe_3_selected

    lda #"Invalid choice, please try again."
    jsr print_string
    jmp start

recipe_1_selected:
    lda #<recipe_1
    ldx #>recipe_1
    jsr print_string
    jmp end

recipe_2_selected:
    lda #<recipe_2
    ldx #>recipe_2
    jsr print_string
    jmp end

recipe_3_selected:
    lda #<recipe_3
    ldx #>recipe_3
    jsr print_string
    jmp end

print_string:
    sta $FB
    stx $FC
    lda ($FB), y
    beq end_print_string
    jsr print_char
    iny
    jmp print_string

print_char:
    cmp #13
    beq end_print_string
    cmp #10
    beq end_print_string
    jsr $FFD2
    rts

end_print_string:
    rts

read_char:
    lda $FFCF
    cmp #13
    beq end_read_char
    jsr print_char
    jmp read_char

end_read_char:
    rts

end:
    rts

