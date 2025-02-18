
ORG $6000

START LDA #0         ; Initialize variables
    STA MAX_LENGTH
    STA CURRENT_LENGTH
    STA MAX_START_INDEX
    STA CURRENT_START_INDEX
    LDX #$00

LOOP LDA ARRAY,X     ; Load value from array at index X
    STA CURRENT_VALUE

    CMP PREVIOUS_VALUE ; Compare value with previous value
    BCC NOT_INCREASING ; If not increasing, go to check length

    INC CURRENT_LENGTH ; Increment current length

    LDA CURRENT_START_INDEX ; Load current start index
    BEQ SET_START_INDEX    ; If start index is 0, set current start index

    JMP LOOP_INC          ; Continue loop

SET_START_INDEX LDA X       ; Set current start index
                STA CURRENT_START_INDEX
                JMP LOOP_INC ; Continue loop

NOT_INCREASING LDA CURRENT_LENGTH ; Check if current length is longer than max length
               CMP MAX_LENGTH
               BCC CHECK_LENGTH

               LDA CURRENT_LENGTH ; Update max length and start index
               STA MAX_LENGTH
               LDA CURRENT_START_INDEX
               STA MAX_START_INDEX

CHECK_LENGTH LDA X              ; Check if end of array
             CMP #ARRAY_SIZE
             BEQ END

             LDA CURRENT_VALUE ; Set previous value
             STA PREVIOUS_VALUE

LOOP_INC INX              ; Increment index
         JMP LOOP        ; Continue loop

END BRK

ARRAY .BYTE $01, $02, $03, $05, $04, $01, $02, $05, $06
ARRAY_SIZE = * - ARRAY

MAX_LENGTH .BYTE
CURRENT_LENGTH .BYTE
MAX_START_INDEX .BYTE
CURRENT_START_INDEX .BYTE
CURRENT_VALUE .BYTE
PREVIOUS_VALUE .BYTE

