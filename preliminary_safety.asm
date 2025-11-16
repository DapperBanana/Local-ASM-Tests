
        .org    $0200
start:  LDX     #0              ; Initialize index
        LDA     arr,X           ; Load first element into A
loop:   CMP     max             ; Compare with current max
        BCC     next            ; Branch if less than current max
        STA     max             ; Update max
next:   INX                     ; Increment index
        CPX     #len            ; Check if end of list
        BCC     loop            ; Repeat loop if not
end:    BRK                     ; Exit program

        .org    $0300
arr:    .byte   $0F, $03, $1E, $05, $29, $07, $C2, $09, $F0, $0B
len =   * - arr
max:    .byte   $00             ; Variable to store current max

        .org    $FFFA
        .word   start           ; Start address of program
