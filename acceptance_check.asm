
; Input:
;   - Source string address in $1000
;   - Target string address in $2000
; Output:
;   - Edit distance in A

    ; Set up pointers and counters
    LDA #0
    STA $EFF0   ; Initialize counter
    LDX #0
    STX $EFF2   ; Initialize pointer for source string
    STX $EFF4   ; Initialize pointer for previous row
    LDX #1
    STX $EFF6   ; Initialize pointer for current row

next_char:
    ; Get source char
    LDA ($EFF2), X
    STA $EF80

    ; Check for end of source string
    LDA $EF80
    BEQ done

    LDX #0
    STX $EFF8   ; Initialize pointer for current column
    
    ; Process target string
    LDA #0
    STA $EF81
    STX $EFFA   ; Initialize pointer for previous column

next_target_char:
    ; Get target char
    LDA ($EFF6), X
    STA $EF82

    ; Check for end of target string
    LDA $EF82
    BEQ move_to_next_char

    ; Calculate distances
    LDA ($EFF4), X
    STA $EF83
    LDA ($EFFA), X
    CLC
    ADC #1
    STA $EF84
    LDX $EF81
    LDA $EF80
    CMP $EF82
    BNE char_not_equal
    ; Characters are equal, no cost
    LDA $EF83
    STA $EF85
    JMP update_distance

char_not_equal:
    ; Characters are different, calculate cost
    LDA $EF83
    CMP $EF84
    BCC choose_min_cost
    LDA $EF84

choose_min_cost:
    LDX $EF8A
    INX
    LDA $EF85, X
    CLC
    ADC #1
    STA $EF85

update_distance:
    STA $EF86

    ; Move to next column
    INX
    STX $EFFA
    
    ; Move to next target char
    INX
    STX $EF81
    JMP next_target_char

move_to_next_char:
    ; Move to next row
    LDX $EFF6
    STX $EFF4
    LDX $EFF8
    STX $EFF6

    ; Move to next char in source string
    LDX $EFF2
    INX
    STX $EFF2
    
    ; Move to next char in source string
    LDX $EFF8
    STX $EFFA

    ; Move to next char in source string
    LDA $EFF0
    CLC
    ADC #1
    STA $EFF0

    ; Move to next char in source string
    JMP next_char

done:
    ; Get final distance from last cell in matrix
    LDX $EFF6
    LDA ($EFF4), X
    TAX

    RTS
