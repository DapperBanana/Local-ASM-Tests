
; Set up random number generation
    LDA #$00
    STA $D010              ; Set seed to 0
    LDA #$EA
    STA $D011              ; Set multiplier to $EA
    LDA #$05
    STA $D012              ; Set increment to $05

; Initialize puzzle grid
    LDX #$00
init_grid:
    LDA #$00
    STA PUZZLE_GRID,X      ; Clear cell in puzzle grid
    INX
    CPX #$40               ; Check if end of grid
    BNE init_grid

; Generate random clues
generate_clues:
    LDA $D011              ; Get current random number
    AND #$3F               ; Mask with 6 bits
    TAX                    ; Store in X register for clue index

    ; Generate random clue type
    LDA $D011              ; Get another random number
    AND #$01               ; Mask with 1 bit
    STA CLUE_TYPES,X       ; Store clue type in memory

    ; Generate random clue value
    LDA $D011              ; Get another random number
    AND #$0F               ; Mask with 4 bits
    STA CLUE_VALUES,X      ; Store clue value in memory

    INX
    CPX #$40               ; Check if end of clues
    BNE generate_clues

; Display crossword puzzle
display_puzzle:
    LDX #$00
display_row:
    LDA PUZZLE_GRID,X
    JSR display_cell
    INX
    CPX #$08                ; Check if end of row
    BNE display_row

    ; Newline
    LDA #$0D
    JSR $FFD2

    CPX #$40                ; Check if end of grid
    BNE display_puzzle

    RTS

display_cell:
    ; Display cell based on contents
    CMP #$00                ; Check if empty cell
    BEQ print_space

    LDA CLUE_TYPES,X
    CMP #$00                ; Check if across clue
    BEQ print_across

    ; Down clue
print_down:
    LDA CLUE_VALUES,X
    JSR print_number
    RTS

print_space:
    LDA #$20                ; Space character
    JMP $FFD2              ; Print character

print_across:
    LDA CLUE_VALUES,X
    JSR print_number
    RTS

print_number:
    CLC
    ADC #$30                ; Convert to ASCII digit
    JMP $FFD2              ; Print character

; Data section
CLUE_TYPES .BYTE $00,$01,$00,$01,$00,$01,$01,$00
CLUE_VALUES .BYTE $01,$03,$04,$02,$09,$06,$07,$05
PUZZLE_GRID .RES 64       ; 8x8 grid for puzzle

