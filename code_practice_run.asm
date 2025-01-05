
; Traffic Simulation Program

; Define memory locations for variables
RED_LIGHT EQU $FC00
YELLOW_LIGHT EQU $FC01
GREEN_LIGHT EQU $FC02
CARS_WAITING EQU $FC03

; Start of program
        ORG $1000

Start   LDA #0          ; Initialize RED light
        STA RED_LIGHT

loop    LDA RED_LIGHT   ; Check current traffic light
        CMP #0
        BEQ redLight

        LDA YELLOW_LIGHT
        CMP #1
        BEQ yellowLight

        LDA GREEN_LIGHT
        CMP #2
        BEQ greenLight

redLight
        LDA CARS_WAITING ; Check if there are cars waiting
        BEQ noCars

        ; RED light timings
        LDX #0
delay1  DEX
        BNE delay1

        LDA YELLOW_LIGHT ; Change to YELLOW light
        STA RED_LIGHT
        STA YELLOW_LIGHT

        JMP loop

yellowLight
        ; YELLOW light timings
        LDX #0
delay2  DEX
        BNE delay2

        LDA GREEN_LIGHT  ; Change to GREEN light
        STA YELLOW_LIGHT
        STA GREEN_LIGHT

        JMP loop

greenLight
        ; GREEN light timings
        LDX #0
delay3  DEX
        BNE delay3

        LDA #0          ; Change to RED light
        STA GREEN_LIGHT
        STA CARS_WAITING

        JMP loop

noCars  ; No cars waiting, keep cycling lights
        JMP loop

        END Start
