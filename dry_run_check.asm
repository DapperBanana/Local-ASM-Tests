
    .org $8000
    
petSleeping:
    .asciiz "Your pet is sleeping."
    
petEating:
    .asciiz "Your pet is eating."
    
petPlaying:
    .asciiz "Your pet is playing."

petHunger:
    .byte 100 ; Initial hunger level
    
petHappiness:
    .byte 100 ; Initial happiness level

main:
    lda #0
    sta petHunger ; Initialize hunger level
    lda #0
    sta petHappiness ; Initialize happiness level
    
    jsr displayMenu ; Display main menu
    
    loop:
    jsr getUserInput ; Get user input
    cmp #1 ; Check if user selected to feed the pet
    beq feedPet ; If so, feed the pet
    cmp #2 ; Check if user selected to play with the pet
    beq playWithPet ; If so, play with pet
    cmp #3 ; Check if user selected to check on the pet
    beq checkOnPet ; If so, check on pet
    cmp #4 ; Check if user selected to exit program
    beq exitProgram ; If so, exit program
    
    jmp loop ; Continue looping until user selects exit
