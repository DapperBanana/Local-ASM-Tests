
START    LDX #0             ; Initialize distance table index
         LDY #0
         LDA STR1_LEN       ; Load length of first string
         STA LEN1
         LDA STR2_LEN       ; Load length of second string
         STA LEN2
         LDA LEN2
         STA Y
         INX                ; Skip loading first byte
         JSR NEXT_BYTE      ; Load first byte of second string
         STX CUR_LEV        ; Initialize current Levenshtein distance
COL_LOOP LDA LEN1          ; Check if finished
         BEQ DONE
         LDX Y
         LDY #0
ROW_LOOP LDA STR1,X
         CMP STR2,Y
         BEQ ROW_MATCH      ; Strings match, skip edit
         LDY CUR_LEV
         CLC
         ADC #$01           ; Increment edit distance
         STA CUR_LEV
ROW_MATCH INX                ; Move to next byte
         INY
         CPY LEN2
         BNE ROW_LOOP
         LDX #0              ; Reset index
         LDA LEN1
         SEC
         SBC Y
         TAX                ; Calculate difference in lengths
         LDA CUR_LEV         ; Fetch current edit distance
         CLC
         ADC TAX             ; Add length difference
         STA CUR_LEV
         LDX LEN1
         LDA STR1,X
         JSR NEXT_BYTE      ; Load next byte of second string
         INX
         DEX                ; Decrement length counter
         STX LEN1
         JMP COL_LOOP        ; Repeat for next column
DONE     LDA CUR_LEV         ; Final edit distance in A
         RTS

NEXT_BYTE LDA STR2,Y         ; Load byte from second string
         RTS

CUR_LEV   .BYTE 0
LEN1      .BYTE 0
LEN2      .BYTE 0
STR1      .ASCII "HELLO"
STR1_LEN  .BYTE $05
STR2      .ASCII "HELLNO"
STR2_LEN  .BYTE $06
