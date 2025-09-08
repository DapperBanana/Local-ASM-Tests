
    LDX #NUMS_COUNT     ; load the number of elements in the list
    LDY #NUMS            ; load the address of the list of numbers
    STY NUMS_PTR

    LDA #1               ; initialize LCM to 1
    STA LCM

LOOP:
    LDA (NUMS_PTR),Y     ; load the next number from the list
    STA NUM
    JSR CALCULATE_LCM    ; calculate LCM of current number and LCM
    DEY
    DEX
    CPX #0               ; check if end of list
    BNE LOOP

    ; LCM is now stored in the LCM variable

END:
    BRK

NUMS_COUNT: .byte 3
NUMS: .byte 6, 8, 10
NUMS_PTR: .byte 0
LCM: .byte 0
NUM: .byte 0

CALCULATE_LCM:
    LDA LCM             ; load current LCM
    STA TEMP_LCM
    LDA NUM             ; load current number
    STA TEMP_NUM

LOOP_CALC:
    CPY TEMP_NUM        ; compare LCM and number
    BEQ END_CALCULATE   ; if equal, exit loop

    CMP TEMP_LCM
    BCC INC_NUMBER      ; if LCM < number, increment number
    BNE INC_LCM         ; if LCM > number, increment LCM
    INC NUMBER

INC_NUMBER:
    INC TEMP_NUM
    JMP LOOP_CALC

INC_LCM:
    INC TEMP_LCM
    JMP LOOP_CALC

END_CALCULATE:
    STA LCM             ; store new LCM in LCM variable
    RTS

TEMP_LCM: .byte 0
TEMP_NUM: .byte 0
