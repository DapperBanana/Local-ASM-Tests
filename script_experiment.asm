
; Program to find the maximum and minimum values in a dictionary
;
; Dictionary format: Key1, Value1, Key2, Value2, ..., 0
; Maximum dictionary size is 10 key-value pairs

MAX_KEYS EQU 10
; Dictionary stored in memory starting at location $2000
DICTIONARY_START EQU $2000

LDA #MAX_KEYS         ; Set number of key-value pairs
STA COUNT

LDA #0                ; Initialize max and min values
STA MAX_VALUE
STA MIN_VALUE

LDA #0                ; Initialize loop counter
STA INDEX

LOOP:
    LDX INDEX
    LDA DICTIONARY_START, X        ; Load current key
    BEQ DONE                       ; Exit loop if key is 0 (end of dictionary)
    INX
    INX                            ; Move to next byte (skip value)
    LDA DICTIONARY_START, X        ; Load current value
    
    CMP MAX_VALUE                 ; Compare current value with max value
    BCC NOT_MAX                   ; If current value is less than max value, skip
    STA MAX_VALUE                 ; Update max value
NOT_MAX:
    CMP MIN_VALUE                 ; Compare current value with min value
    BCS NOT_MIN                   ; If current value is greater than min value, skip
    STA MIN_VALUE                 ; Update min value
NOT_MIN:
    INC INDEX                      ; Move to next key
    JMP LOOP

DONE:
    ; Max value is in MAX_VALUE
    ; Min value is in MIN_VALUE
    
    ; Code to handle max and min values goes here

    RTS
