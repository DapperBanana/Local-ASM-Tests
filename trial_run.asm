
; Calculate the area of a pentagon using the formula: A = 1/4 * sqrt(5 * (5 + 2 * sqrt(5))) * s^2

; Define variables
SQUARE_SIDE_LENGTH = $05  ; Side length of the pentagon
AREA = $00               ; Area of the pentagon
TEMP = $01               ; Temporary storage

; Code starts here
        LDA SQUARE_SIDE_LENGTH     ; Load s into accumulator
        STA TEMP                   ; Store s in TEMP

        LDA #5                     ; Load 5 into accumulator
        CLC                        ; Clear carry flag
        ADC SQUARED_SIDE_LENGTH    ; Add 2s to accumulator
        ADC SQUARED_SIDE_LENGTH
        STA TEMP                   ; Store 5 + 2s in TEMP

        LDA #81                    ; Load 81 into accumulator
        STA $02                     ; Store 81 in TEMP+1
        LDA TEMP+1                 ; Load 0 into accumulator
        ADC $02                    ; Add 81 to accumulator
        STA TEMP+1                 ; Store 81 in TEMP+1

        JSR SQRT                   ; Calculate square root of TEMP
        ASL                        ; Multiply by 2 (shift left)
        STA TEMP                   ; Store 2 * sqrt(5 * (5 + 2 * sqrt(5))) in TEMP

        LDA TEMP                   ; Load result into accumulator
        LSR                        ; Divide by 4 (shift right)
        STA TEMP                   ; Store area in TEMP

        LDA TEMP                   ; Load area into accumulator
        STA AREA                   ; Store area in AREA

        BRK                        ; Return

SQRT    ; Calculate square root of value in TEMP
        LDA TEMP
        LDY #0
LOOP
        ASL
        ROL TEMP+1
        CPY #7
        BNE LOOP
        ROR TEMP
        ROR TEMP+1
        RTS
