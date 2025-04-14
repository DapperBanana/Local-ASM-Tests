
.org $0200

STRT    LDX #$00        ; Initialize index register
LOOP    LDA MENU,X      ; Load menu option into accumulator
        JSR PRINTLN     ; Print menu option
        LDA #">"         ; Load ">" character into accumulator
        JSR PRINT       ; Print ">" character
        JSR READCHAR     ; Read user input
        CMP #"1"         ; Compare user input to "1"
        BEQ ADD_ITEM     ; If user input is "1", go to ADD_ITEM
        CMP #"2"         ; Compare user input to "2"
        BEQ REMOVE_ITEM   ; If user input is "2", go to REMOVE_ITEM
        CMP #"3"         ; Compare user input to "3"
        BEQ PRINT_ITEMS   ; If user input is "3", go to PRINT_ITEMS
        JMP INVALID_INPUT ; If user input is not valid, go to INVALID_INPUT

ADD_ITEM
        JSR PRINTLN     ; Print empty line for spacing
        LDX #$00        ; Reset index register
ADD_LOOP
        LDA ITEMS,X     ; Load item at index X
        BEQ ADD_DONE    ; If item is empty, go to ADD_DONE
        INX             ; Increment index
        JMP ADD_LOOP    ; Continue loop

ADD_DONE
        JSR PRINTLN     ; Print empty line for spacing
        LDA #"+"         ; Load "+" character into accumulator
        JSR PRINT       ; Print "+" character
        JSR READCHAR     ; Read user input for new item
        STA ITEMS,X     ; Store new item at index X
        JMP STRT        ; Go back to main menu

REMOVE_ITEM
        JSR PRINTLN     ; Print empty line for spacing
        LDX #$00        ; Reset index register
REMOVE_LOOP
        LDA ITEMS,X     ; Load item at index X
        BEQ REMOVE_DONE ; If item is empty, go to REMOVE_DONE
        JSR PRINTLN     ; Print item
        JSR PRINTLN     ; Print empty line for spacing
        INX             ; Increment index
        JMP REMOVE_LOOP ; Continue loop

REMOVE_DONE
        JSR PRINTLN     ; Print empty line for spacing
        LDA #"-"         ; Load "-" character into accumulator
        JSR PRINT       ; Print "-" character
        JSR READCHAR     ; Read user input for item to remove
        STA ITEMS,X     ; Remove item at index X
        JMP STRT        ; Go back to main menu

PRINT_ITEMS
        JSR PRINTLN     ; Print empty line for spacing
        LDX #$00        ; Reset index register
PRINT_LOOP
        LDA ITEMS,X     ; Load item at index X
        BEQ PRINT_DONE  ; If item is empty, go to PRINT_DONE
        JSR PRINTLN     ; Print item
        INX             ; Increment index
        JMP PRINT_LOOP  ; Continue loop

PRINT_DONE
        JSR PRINTLN     ; Print empty line for spacing
        JMP STRT        ; Go back to main menu

INVALID_INPUT
        JSR PRINTLN     ; Print error message
        JMP STRT        ; Go back to main menu

PRINTLN
        LDX #$00        ; Reset index register
PRINTLN_LOOP
        LDA #0A          ; Load newline character into accumulator
        JSR PRINT       ; Print newline character
        INX             ; Increment index
        CPX #$03        ; Compare index to 3
        BNE PRINTLN_LOOP ; If index is not 3, continue loop
        RTS             ; Return from subroutine

PRINT
        STA $D011       ; Store character in screen data register
        LDA $D012       ; Load screen control register
        ORA #$02        ; Set bit 1 to enable screen data register
        STA $D012       ; Store updated value in screen control register
        RTS             ; Return from subroutine

READCHAR
        LDA $D013       ; Load keyboard data register
        CMP #$6F        ; Compare input to max ASCII value
        BCS READCHAR    ; Keep waiting for input if out of range
        RTS             ; Return from subroutine

MENU    .text "1. Add item",0
        .byte 0
        .text "2. Remove item",0
        .byte 0
        .text "3. Print items",0
        .byte 0

ITEMS   .byte 0,0,0
