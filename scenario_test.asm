
; Assume the two lists are stored in memory starting at addresses LIST1 and LIST2
; and the length of each list is stored at addresses LEN1 and LEN2, respectively

        .org $0200  ; Start of program
        LDX #0      ; Initialize index for LIST1
LOOP1   LDA LIST1,X ; Load element from LIST1
        BNE CHECK   ; Check if element is non-zero
        BRK         ; Exit loop if element is zero
CHECK   STX INDEX  ; Save current index in INDEX
        LDY #0      ; Initialize index for LIST2
LOOP2   LDA LIST2,Y ; Load element from LIST2
        BNE COMPARE ; Check if element is non-zero
        BEQ NEXT    ; Exit loop if element is zero
COMPARE CMP LIST1,X ; Compare elements
        BMI NEXT    ; Move to next element if not equal
        JSR PRINT   ; Print the common element
NEXT    INY         ; Move to next element in LIST2
        JMP LOOP2   ; Repeat loop for LIST2
PRINT   ; Code to print common element
        ...
        RTS         ; Return from subroutine

INDEX   .byte 0      ; Variable to store index of common element

LIST1   ; Define the first list
        .byte 1, 2, 3, 4, 5, 6, 0 ; Zero terminator

LIST2   ; Define the second list
        .byte 4, 5, 6, 7, 8, 0 ; Zero terminator

LEN1    = * - LIST1 - 1 ; Calculate length of LIST1
LEN2    = * - LIST2 - 1 ; Calculate length of LIST2

        .org $FFFA  ; Set NMI, RESET, and IRQ vectors
        .word $0200 ; Start of program

        .end        ; End of program
