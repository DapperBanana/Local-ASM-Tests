
; Simple program to read data from memory and print it to the screen
        .org $0200

start   LDX #$00            ; initialize index register
loop    LDA data,X          ; load data from memory location specified by X
        BEQ end             ; if end of data is reached, exit loop
        JSR $FFD2           ; print character to the screen
        INX                 ; increment index
        JMP loop            ; repeat loop
end     BRK                 ; exit program

data    .byte "Hello, world!", 0

        .end
