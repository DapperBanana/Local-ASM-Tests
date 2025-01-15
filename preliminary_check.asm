
; Longest Common Subsequence program in 6502 Assembly

.ORG $1000

; Strings to compare
string1 .BYTE "ABCBDAB", 0
string2 .BYTE "BDCAB", 0

; Variables
common_subsequence .BLOCK 256
dp_table .BLOCK 64

START:
    ; Initialize variables
    LDX #0
    STX common_subsequence

    ; Initialize dynamic programming table
    LDX #0
INIT_DP_TABLE_LOOP:
    LDA #0
    STA dp_table, X
    INX
    CPX #64
    BNE INIT_DP_TABLE_LOOP

    ; Find the length of the common subsequence
    LDX #0
FIND_COMMON_SUBSEQUENCE_LOOP:
    CMP string1, X
    BEQ CHECK_COMMON_SUBSEQUENCE
    LDX #0
    JMP END
CHECK_COMMON_SUBSEQUENCE:
    LDY #0
    LDX #0
CHECK_COMMON_SUBSEQUENCE_LOOP:
    CMP string2, Y
    BEQ UPDATE_DP_TABLE
    INY
    CPY #6
    BNE CHECK_COMMON_SUBSEQUENCE_LOOP
    JMP END
UPDATE_DP_TABLE:
    LDA dp_table, X
    CLC
    ADC #1
    STA dp_table, X

    CMP dp_table, X
    BCC NEXT_CHARACTER

    LDA dp_table, X
    STA common_subsequence
NEXT_CHARACTER:
    INX
    CPX #64
    BNE FIND_COMMON_SUBSEQUENCE_LOOP
END:
    ; End of program
    BRK

