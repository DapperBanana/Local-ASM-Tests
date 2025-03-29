
SEED = $01
ESTIMATE = $02
NUM = $03
RESULT = $04

    ORG $0200   ; Start of program

start:
    LDA #25     ; Load the number for which to find the square root
    STA NUM     ; Store it in memory
    LDA #0
    STA SEED    ; Initialize seed value
    LDA #128    ; Initial estimate for square root
    STA ESTIMATE

loop:
    LDA ESTIMATE
    CLC
    ADC SEED    ; Add seed to estimate
    LSR         ; Divide by 2
    STA RESULT

    LDA RESULT
    CMP SEED
    BEQ done    ; If estimate and seed are equal, exit loop

    LDA NUM
    SEC
    SBC RESULT  ; Calculate the difference between number and result
    STA NUM

    LDA ESTIMATE
    STA SEED    ; Update seed
    STA ESTIMATE ; Update estimate
    JMP loop    ; Repeat the loop

done:
    ; The square root of the given number is now stored in memory at location RESULT

    JMP $0200   ; End of program, loop back to start
