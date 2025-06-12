
    .org $0200
    
start
    ; Display welcome message
    jsr displayWelcomeMessage
    
    ; Display movie categories
    jsr displayCategories
    
    ; Get user input for movie category
    jsr getUserInput
    
    ; Recommend a movie based on user input
    lda $FF
    cmp #$01
    beq action
    cmp #$02
    beq comedy
    cmp #$03
    beq drama
    jmp error
    
action
    jsr displayActionMovie
    jmp end
    
comedy
    jsr displayComedyMovie
    jmp end
    
drama
    jsr displayDramaMovie
    jmp end
    
error
    jsr displayErrorMessage
    
end
    ; Halt program
    brk

displayWelcomeMessage
    lda #$FF
    jsr $FFD2
    lda #<welcomeMessage
    ldx #>welcomeMessage
    jsr $FFD2
    rts

welcomeMessage
    .text "Welcome to the Movie Recommendation System!"

displayCategories
    lda #$FF
    jsr $FFD2
    lda #<"Please select a movie category:"
    ldx #>"Please select a movie category:"
    jsr $FFD2
    lda #<actionCategory
    ldx #>actionCategory
    jsr $FFD2
    lda #<comedyCategory
    ldx #>comedyCategory
    jsr $FFD2
    lda #<dramaCategory
    ldx #>dramaCategory
    jsr $FFD2
    rts

actionCategory
    .text "1. Action"
    
comedyCategory
    .text "2. Comedy"
    
dramaCategory
    .text "3. Drama"

getUserInput
    lda #$FF
    jsr $FFD2
    lda #<"Enter the number of your chosen category:"
    ldx #>"Enter the number of your chosen category:"
    jsr $FFD2
    lda #$00
    jsr $FFD2
    rts

displayActionMovie
    lda #$FF
    jsr $FFD2
    lda #<actionMovie
    ldx #>actionMovie
    jsr $FFD2
    rts

actionMovie
    .text "Recommended Action Movie: Die Hard"

displayComedyMovie
    lda #$FF
    jsr $FFD2
    lda #<comedyMovie
    ldx #>comedyMovie
    jsr $FFD2
    rts

comedyMovie
    .text "Recommended Comedy Movie: Airplane!"

displayDramaMovie
    lda #$FF
    jsr $FFD2
    lda #<dramaMovie
    ldx #>dramaMovie
    jsr $FFD2
    rts

dramaMovie
    .text "Recommended Drama Movie: The Shawshank Redemption"

displayErrorMessage
    lda #$FF
    jsr $FFD2
    lda #<"Error: Invalid category selection."
    ldx #>"Error: Invalid category selection."
    jsr $FFD2
    rts
