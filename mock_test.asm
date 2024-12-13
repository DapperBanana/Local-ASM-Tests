
        .org $0600  ; Start address of the program

start   LDX #8      ; Load the number of elements in the list
        LDY #0      ; Initialize index Y
loop1   LDA list,Y  ; Load the current element into the accumulator
        STA current ; Store it in memory as the current element
        
        LDX #0      ; Initialize index X
loop2   LDA list,X  ; Load the next element into the accumulator
        CMP current ; Compare it with the current element
        BCC skip    ; If next element is smaller, skip to the next element
        STA temp    ; Store the next element in a temporary variable
        STA list,Y  ; Swap the elements (current <-- next)
        STA list,X  ; (next <-- current)
        LDA temp    ; Load the current element back into the accumulator
        STA list,X  ; Store it in its new position
skip    INX         ; Increment index X
        CPX #7      ; Check if we have reached the end of the list
        BNE loop2   ; If not, go back to loop2
        
        INY         ; Increment index Y
        CPY #7      ; Check if we have compared all elements
        BNE loop1   ; If not, go back to loop1
        
        BRK         ; End of the program

list    .byte 9, 3, 5, 1, 4, 7, 2, 6 ; List of integers to be sorted
current .byte 0       ; Variable to store the current element
temp    .byte 0       ; Temporary variable for swapping

        .end        ; End of the program
