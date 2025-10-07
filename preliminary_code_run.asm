
        .org $0200              ; Start program at memory address $0200

start   LDX #15                ; Set initial count of cars on road
loop    STX cars               ; Store count of cars in memory
        JSR display            ; Display road with cars
        JSR delay              ; Delay for a second
        DEC cars               ; Decrement count of cars
        BNE loop               ; Loop until no cars left

        BRK

display LDX cars               ; Load count of cars
        LDY #32                ; Set Y to ASCII space character
loop2   CPX #0                 ; Check if there are any cars left
        BEQ done               ; If no cars left, return
        STA $0400,X            ; Load car onto road
        DEX                    ; Decrement X
        DEY                    ; Decrement Y
        BNE loop2              ; Loop until all cars are displayed
done    RTS

delay   LDX #60                ; Set delay counter
        LDA #0                 ; Clear A register
delay1  DEX                    ; Decrement delay counter
        BNE delay1             ; Loop while counter is not zero
        RTS

cars    .byte 0                ; Variable to store count of cars

        .org $0400              ; Start of display memory for road
road    .byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32 ; Empty road
