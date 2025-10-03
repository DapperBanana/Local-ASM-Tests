
        .org $0200
        
        LDX #8            ; set number of integers in the list
        LDY #0            ; initialize inner loop index
        
outerLoop:
        LDA $1000, Y      ; load next integer from the list
        STA $0200, Y      ; store current integer to the temporary buffer
        
        LDX #0            ; initialize outer loop index
        LDY #0            ; initialize inner loop index
        
innerLoop:
        CMP $0200, X      ; compare current integer with the rest of the list
        BCC notSwap       ; skip if the current integer is smaller
        
        LDA $0200, X      ; swap current integer with the larger one
        STA $0200, X
        
        LDA $1000, Y      ; move larger integer to the temporary buffer
        STA $0200, Y
        
notSwap:
        INX               ; move to the next integer
        CPX #8            ; check if we have reached the end of the list
        BNE innerLoop     ; repeat inner loop if not
        
        LDY #0            ; reset inner loop index
        
        INY               ; move to the next integer in the outer loop
        CPY #8            ; check if we have reached the end of the list
        BNE outerLoop     ; repeat outer loop if not
        
        BRK               ; end program
        
        .org $1000
        
        .word 3, 6, 2, 8, 1, 5, 4, 7 ; list of integers to sort
