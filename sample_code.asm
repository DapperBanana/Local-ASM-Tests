
; 6502 Assembly program for a basic text-based recipe recommendation system

.org $0200

START:
    LDX #0              ; Initialize counter for number of ingredients
    STX INGREDIENTS
    
    LDA #MSG_WELCOME    ; Print welcome message
    JSR PRINT_MESSAGE
    
GET_INGREDIENT:
    LDA #MSG_INGREDIENT ; Prompt user for ingredient
    JSR PRINT_MESSAGE
    
    JSR GET_INPUT       ; Get user input
    
    CMP #END            ; Check if user input is "end" to stop adding ingredients
    BEQ CHECK_RECIPE
    
    INX                 ; Increment ingredient counter
    STA INGREDIENT1, X  ; Store input in ingredients array
    
    JMP GET_INGREDIENT  ; Repeat to get more ingredients
    
CHECK_RECIPE:
    LDA INGREDIENTS     ; Check if user input any ingredients
    BEQ NO_INGREDIENTS  ; If no ingredients, display message
    
    LDA #MSG_RECIPE     ; Recommending a recipe using ingredients
    JSR PRINT_MESSAGE
    
    LDA #INGREDIENT1
    LDY #0
PRINT_INGREDIENTS:
    LDA (Y), X          ; Print out all the ingredients
    JSR PRINT_CHAR
    
    INY
    CPY INGREDIENTS     ; Check if reached end of ingredients
    BNE PRINT_INGREDIENTS
    
    BNE END
    
NO_INGREDIENTS:
    LDA #MSG_NO_INGREDIENTS ; Display message if no ingredients provided
    JSR PRINT_MESSAGE
    
END:
    
    BRK                 ; End program


MSG_WELCOME:
    .text "Welcome to the recipe recommendation system!\n"
    .byte 0
    
MSG_INGREDIENT:
    .text "Please enter an ingredient (or type \"end\" to finish): \n"
    .byte 0
    
MSG_RECIPE:
    .text "Here is a recommended recipe using the ingredients provided:\n"
    .byte 0
    
MSG_NO_INGREDIENTS:
    .text "No ingredients provided. Please try again.\n"
    .byte 0
    
INGREDIENTS:
    .byte 0
    
INGREDIENT1:
    .byte 20       ; Maximum of 20 ingredients
