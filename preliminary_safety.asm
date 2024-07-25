
; 6502 Assembly program to calculate the area of a rectangle given its length and width

        .org $0200
        
        LDA #LENGTH       ; Load length of rectangle into accumulator
        STA RECT_LENGTH   ; Store length in memory
        
        LDA #WIDTH        ; Load width of rectangle into accumulator
        STA RECT_WIDTH    ; Store width in memory
        
        ; Calculate area of rectangle
        LDA RECT_LENGTH    ; Load length from memory
        CLC                ; Clear carry flag
        ADC RECT_WIDTH     ; Add width to accumulator
        STA RECT_AREA      ; Store result in memory
        
        ; Output result
        LDA RECT_AREA      ; Load area from memory
        STA $D020          ; Output result to screen
        
        BRK                ; Halt program
        
LENGTH: .byte 10        ; Length of rectangle
WIDTH:  .byte 5         ; Width of rectangle
RECT_LENGTH: .byte 0   ; Memory location to store length
RECT_WIDTH:  .byte 0    ; Memory location to store width
RECT_AREA:   .byte 0    ; Memory location to store area
