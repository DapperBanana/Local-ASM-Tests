
        .org $0200

start   lda #<prompt      ; Load the low byte of the address of the prompt into the accumulator
        sta $FC           ; Store the low byte of the prompt address in $FC
        lda #>prompt      ; Load the high byte of the address of the prompt into the accumulator
        sta $FD           ; Store the high byte of the prompt address in $FD
        
        jsr $FFFC         ; Call the subroutine at $FFFC to print the prompt
        
loop    lda #<options     ; Load the low byte of the address of the options into the accumulator
        sta $FC           ; Store the low byte of the options address in $FC
        lda #>options     ; Load the high byte of the address of the options into the accumulator
        sta $FD           ; Store the high byte of the options address in $FD
        
        jsr $FFFC         ; Call the subroutine at $FFFC to print the options
        
        lda $FFFA         ; Load user input into the accumulator
        cmp #"1"          ; Compare user input to "1"
        beq recommend     ; If user input is "1", branch to recommend
        
        lda $FFFA         ; Load user input into the accumulator
        cmp #"2"          ; Compare user input to "2"
        beq list          ; If user input is "2", branch to list
        
        jmp loop          ; otherwise, repeat the loop
        
recommend
        lda #<recommendation   ; Load the low byte of the address of the recommendation into the accumulator
        sta $FC                ; Store the low byte of the recommendation address in $FC
        lda #>recommendation   ; Load the high byte of the address of the recommendation into the accumulator
        sta $FD                ; Store the high byte of the recommendation address in $FD
        
        jsr $FFFC              ; Call the subroutine at $FFFC to print the recommendation
        
        jmp loop              ; Go back to the main loop

list
        lda #<movieList     ; Load the low byte of the address of the movieList into the accumulator
        sta $FC             ; Store the low byte of the movieList address in $FC
        lda #>movieList     ; Load the high byte of the address of the movieList into the accumulator
        sta $FD             ; Store the high byte of the movieList address in $FD
        
        jsr $FFFC           ; Call the subroutine at $FFFC to print the movieList
        
        jmp loop            ; Go back to the main loop

prompt  .text "Welcome to the Movie Recommendation System! Press 1 for a recommendation or 2 for a list of movies: $00"

options .text "1 - Get movie recommendation $00"
        .text "2 - List of recommended movies $00"

recommendation .text "We recommend you watch 'Inception' $00"

movieList .text "1. Inception $00"
         .text "2. The Shawshank Redemption $00"
         .text "3. The Godfather $00"
