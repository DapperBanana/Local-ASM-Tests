
        .org $0200

start   lda #10         ; Load the decimal number into the accumulator
        sta num         ; Store the decimal number in memory
        ldx #$08        ; Set up a loop counter for 8 bits
        
convert lsr num         ; Shift the number right to extract the least significant bit
        rol bin         ; Rotate the resulting bit into the binary number
        dex             ; Decrement loop counter
        bne convert     ; Repeat loop until all 8 bits have been processed

        lda bin         ; Load the binary number into the accumulator
        sta $0300       ; Store the result in memory

end     brk             ; Halt the program

num     .byte 0         ; Decimal number to convert
bin     .byte 0         ; Binary equivalent

        .org $0300       ; Memory location to store the result
