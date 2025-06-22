
PET_START:
    LDA #0
    STA PET_HUNGER
    STA PET_HAPPINESS

PET_LOOP:
    ; Display pet status
    JSR DISPLAY_STATUS
    
    ; Check for user input
    JSR CHECK_INPUT

    ; Update pet status
    JSR UPDATE_STATUS

    ; Check if pet has died
    LDA PET_HUNGER
    CMP #100
    BEQ PET_DIED

    JMP PET_LOOP

PET_DIED:
    JSR DISPLAY_DEAD_MESSAGE
    RTS

DISPLAY_STATUS:
    ; Display hunger level
    LDA PET_HUNGER
    STA $D020 ; Output to screen

    ; Display happiness level
    LDA PET_HAPPINESS
    STA $D021 ; Output to screen

    RTS

CHECK_INPUT:
    LDX $D011 ; Read user input
    CPX #1
    BEQ FEED_PET
    CPX #2
    BEQ PLAY_WITH_PET

    RTS

FEED_PET:
    ; Increase hunger level
    LDA PET_HUNGER
    CLC
    ADC #10
    STA PET_HUNGER

    RTS

PLAY_WITH_PET:
    ; Increase happiness level
    LDA PET_HAPPINESS
    CLC
    ADC #10
    STA PET_HAPPINESS

    RTS

UPDATE_STATUS:
    ; Decrease hunger level
    LDA PET_HUNGER
    SEC
    SBC #1
    STA PET_HUNGER

    ; Decrease happiness level
    LDA PET_HAPPINESS
    SEC
    SBC #1
    STA PET_HAPPINESS

    RTS

PET_HUNGER .BYTE 0
PET_HAPPINESS .BYTE 0
