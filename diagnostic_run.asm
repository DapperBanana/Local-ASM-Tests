
        .org    $0600

list    .byte   $01, $02, $03, $04, $05
sum     .byte   $00

        LDX     #0              ; Initialize the index X to 0
        LDY     #0              ; Initialize the sum Y to 0

loop    LDA     list, X         ; Load the value at index X into A
        CLC                     ; Clear the carry flag
        ADC     Y               ; Add the value to the sum Y
        STA     sum             ; Store the updated sum
        INX                     ; Increment the index X
        CPX     #5              ; Compare the index to the length of the list
        BNE     loop            ; Continue looping if not at the end of the list

done    BRK                     ; End the program

        .end
