
        ; Program to reverse a string
        ; Input: String stored at start of memory address 0x0200
        ; Output: Reversed string stored at start of memory address 0x0300

START   LDA #$00            ; Initialize index register
        STA $02             ; Initialize destination index
        LDX #$FF            ; Loop through memory addresses from $00FF to $0200
REVERSE LDY $02             ; Load destination index into Y register
        LDA $0200,X         ; Load character from original string
        STA $0300,Y         ; Store character in reversed string
        DEY                 ; Decrement destination index
        DEX                 ; Decrement memory address index
        CPX #$00            ; Check if reached end of original string
        BNE REVERSE         ; If not, repeat loop
        INY                 ; Increment destination index
        LDA #$00            ; Add null terminator
        STA $0300,Y
        BRK                 ; End program

        .org $0200           ; Start of original string
        .byte "Hello, World!"        

        .org $0300           ; Start of reversed string

        .end
