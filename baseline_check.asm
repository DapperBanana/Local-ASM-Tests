
; Movie Recommendation System

    .org $0200

start:
    lda #0          ; Initialize accumulator
    sta $1000       ; Initialize memory location to store user's choice
    
    jsr displayMenu ; Call subroutine to display menu
    jsr getUserChoice ; Call subroutine to get user's choice
    
    lda $1000       ; Load user's choice
    cmp #1          ; Compare with option 1
    beq recommendAction ; Branch if equal to recommend
    cmp #2          ; Compare with option 2
    beq recommendComedy ; Branch if equal to comedy
    cmp #3          ; Compare with option 3
    beq recommendDrama ; Branch if equal to drama
    jmp start       ; Return to start if invalid choice

recommendAction:
    lda #"Die Hard"  ; Load recommended action movie
    jsr displayMovie ; Call subroutine to display recommended movie
    jmp start

recommendComedy:
    lda #"Dumb and Dumber" ; Load recommended comedy movie
    jsr displayMovie ; Call subroutine to display recommended movie
    jmp start

recommendDrama:
    lda #"The Shawshank Redemption" ; Load recommended drama movie
    jsr displayMovie ; Call subroutine to display recommended movie
    jmp start

displayMenu:
    lda #"Movie Recommendation System" ; Display title
    jsr printString
    lda #13          ; Display newline character
    jsr printChar
    lda #10          ; Display carriage return
    jsr printChar
    
    lda #"1. Action" ; Display menu options
    jsr printString
    lda #13
    jsr printChar
    lda #10
    jsr printChar
    
    lda #"2. Comedy"
    jsr printString
    lda #13
    jsr printChar
    lda #10
    jsr printChar
    
    lda #"3. Drama"
    jsr printString
    lda #13
    jsr printChar
    lda #10
    jsr printChar
    rts

getUserChoice:
    lda #"Enter your choice: " ; Prompt user for choice
    jsr printString
    
    lda $FF00        ; Load user input
    sta $1000        ; Store user's choice
    rts

displayMovie:
    lda #"Recommended Movie: " ; Display recommendation
    jsr printString
    lda #13
    jsr printChar
    lda #10
    jsr printChar
    
    lda (pointer),y ; Load movie title
    jsr printString
    lda #13
    jsr printChar
    lda #10
    jsr printChar
    rts

printString:
    sta $FE00        ; Store character to display
    lda $FE00        ; Load character
    cmp #0           ; Check for null terminator
    beq endString    ; Branch if end of string
    lda $FE00        ; Load character
    jsr printChar    ; Call subroutine to display character
    iny              ; Increment Y register
    jmp printString  ; Repeat for next character

endString:
    rts

printChar:
    sta $FD00        ; Store character to display
    ldx $FD00        ; Load character to X register
    jsr $FFD2        ; Call KERNAL routine to output character
    rts

    .memory $0200,$FF00,$FD00,$FE00
    .addr pointer

    .block "Die Hard",0
    .block "Dumb and Dumber",0
    .block "The Shawshank Redemption",0
