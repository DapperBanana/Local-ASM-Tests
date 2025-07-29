
; Find the median of a list of numbers
; Assume that the list of numbers is stored in memory starting at address $2000
; Assume that the length of the list is stored at address $2001

START:
    LDX #$00         ; Initialize index
    LDY $2001        ; Load length of list
    LDA #$00         ; Initialize sum
    STA SUM
LOOP:
    LDA $2000, X     ; Load number from list
    CLC
    ADC SUM          ; Add to sum
    STA SUM
    INX              ; Increment index
    CPX Y            ; Check if end of list
    BNE LOOP

    LDX #$00         ; Reset index
    LDA SUM          ; Load sum
    JSR DIV_BY_LEN   ; Divide sum by length to get average
    STA AVG

    LDX #$00         ; Reset index
    LDA AVG
    TAY
    LDA $2000, Y     ; Load number that is closest to average
    STA NUM1

    LDA AVG
    INY
    LDA $2000, Y     ; Load next number
    CMP NUM1         ; Compare to find the closer number
    BCC SMALLER
    BCS LARGER
LARGER:
    STA NUM2
    JMP MEDIAN_DONE
SMALLER:
    LDA AVG
    STA NUM2
    STA NUM1
    JMP MEDIAN_DONE

DIV_BY_LEN:
    LDA SUM
    SEC
    SBC #$00         ; Divide sum by length
    SBC $2001
    SBC #$00
    LSR
    LSR
    LSR
    STA SUM
    RTS

MEDIAN_DONE:
    ; Now NUM1 and NUM2 contains the two median candidates, find the median
    LDA NUM1
    LDX #$00
    LDA AVG
    CMP NUM2
    BCS SKIP_SWAP
    STX TEMP
    STA NUM1
    LDA NUM2
    TXA
    STA NUM2
    LDA TEMP
    STA AVG

SKIP_SWAP:
    ; Now NUM1 contains the lower median candidate, NUM2 contains the higher median candidate
    ; If the number of elements is even, find the average of the two medians
    LDA $2001
    AND #$01         ; Check if number of elements is odd or even
    BEQ FIND_AVG

OUTPUT_MEDIAN:
    LDA NUM1         ; Output median
    STA $2002
    LDA NUM2
    STA $2003
    RTS

FIND_AVG:
    LDA NUM1
    CLC
    ADC NUM2
    LSR
    STA NUM1         ; Compute average of two medians
    LDA AVG
    STA NUM2
    JMP OUTPUT_MEDIAN

SUM     .BYTE $00     ; Variable to store sum of numbers
AVG     .BYTE $00     ; Variable to store average
NUM1    .BYTE $00     ; Variable to store lower median candidate
NUM2    .BYTE $00     ; Variable to store higher median candidate
TEMP    .BYTE $00     ; Temporary variable for swapping
