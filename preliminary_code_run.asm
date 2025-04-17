
; Sudoku Validation Program

ORG $0200

START:
    JSR READ_BOARD   ; Read the Sudoku board into memory
    JSR VALIDATE_ROWS   ; Validate each row of the board
    JSR VALIDATE_COLUMNS   ; Validate each column of the board
    JSR VALIDATE_BLOCKS   ; Validate each 3x3 block of the board

    BRK

READ_BOARD:
    LDX #0   ; Initialize X index to 0
READ_NEXT_ROW:
    LDA #9   ; Load 9 bytes for each row
    STA $0200,X   ; Store the start address of each row
    INX   ; Increment X index
    BNE READ_NEXT_ROW   ; Continue reading rows until all 9 have been read

    RTS

VALIDATE_ROWS:
    LDX #0   ; Initialize X index to 0
VALIDATE_NEXT_ROW:
    LDA $0200,X   ; Load start address of current row
    STA $FE   ; Store it in the memory buffer
    LDA #$0   ; Initialize error flag
    STA $FF   ; Store it in the memory buffer

    LDA $FE   ; Load start address of current row
    CLC
    ADC #$9   ; Calculate end address of current row
    STA $FD   ; Store it in the memory buffer
    LDX #1   ; Initialize Y counter to 1

ROW_LOOP:
    LDA ($FE),X   ; Load value at current cell address
    STA $FC   ; Store it in the memory buffer
    LDA $FC   ; Load value at current cell
    BEQ ROW_NEXT   ; Skip if cell is empty

    ; Check if current value is valid
    LDX #1   ; Initialize Y index to 1
    LDA #9   ; Number of cells in a row
    JSR CHECK_VALUE   ; Check if current value is valid
    BEQ ROW_NEXT   ; Move to next cell if value is valid

    ; Invalid value found
    INC $FF   ; Set error flag to 1

ROW_NEXT:
    INX   ; Increment X index
    CMP $FD   ; Compare current row cell address with end address
    BNE ROW_LOOP   ; Continue checking cells until end of row is reached

    INC $FE   ; Increment current row start address
    LDX $FE   ; Load current row start address
    CPX #$0369   ; Compare current row start address with end address
    BNE VALIDATE_NEXT_ROW   ; Continue validating next row if not end of board

    RTS

VALIDATE_COLUMNS:
    LDX #0   ; Initialize X index to 0
VALIDATE_NEXT_COLUMN:
    LDA $0200,X   ; Load start address of current column
    STA $FE   ; Store it in the memory buffer
    LDA #$0   ; Initialize error flag
    STA $FF   ; Store it in the memory buffer

    LDA #$0   ; Set current cell to 0
    STA $FC   ; Store it in the memory buffer
    LDA $FE   ; Load start address of current column
    CLC
    ADC #$81   ; Calculate end address of current column
    STA $FD   ; Store it in the memory buffer

    LDX #0   ; Initialize Y index to 0

COLUMN_LOOP:
    LDA ($FE),X   ; Load value at current cell address
    STA $FC   ; Store it in the memory buffer
    LDA $FC   ; Load value at current cell
    BEQ COLUMN_NEXT   ; Skip if cell is empty

    ; Check if current value is valid
    LDX #9   ; Initialize Y index to 9
    LDA #9   ; Number of cells in a column
    JSR CHECK_VALUE   ; Check if current value is valid
    BEQ COLUMN_NEXT   ; Move to next cell if value is valid

    ; Invalid value found
    INC $FF   ; Set error flag to 1

COLUMN_NEXT:
    INX   ; Increment X index
    CMP $FD   ; Compare current column cell address with end address
    BNE COLUMN_LOOP   ; Continue checking cells until end of column is reached

    INC $FE   ; Increment current column start address
    LDX $FE   ; Load current column start address
    CPX #$09   ; Compare current column start address with end address
    BNE VALIDATE_NEXT_COLUMN   ; Continue validating next column if not end of board

    RTS

VALIDATE_BLOCKS:
    LDX #0   ; Initialize X index to 0
VALIDATE_NEXT_BLOCK:
    LDA $0200,X   ; Load start address of current block
    STA $FE   ; Store it in the memory buffer
    LDA #$0   ; Initialize error flag
    STA $FF   ; Store it in the memory buffer

    LDX #0   ; Initialize Y index to 0
    LDX #$0   ; Set current cell to 0

BLOCK_LOOP:
    LDA ($FE),X   ; Load value at current cell address
    STA $FC   ; Store it in the memory buffer
    LDA $FC   ; Load value at current cell
    BEQ BLOCK_NEXT   ; Skip if cell is empty

    ; Check if current value is valid
    LDX #$1   ; Initialize Y index to 1
    LDA #9   ; Number of cells in a block
    JSR CHECK_VALUE   ; Check if current value is valid
    BEQ BLOCK_NEXT   ; Move to next cell if value is valid

    ; Invalid value found
    INC $FF   ; Set error flag to 1

BLOCK_NEXT:
    INX   ; Increment X index
    CPX #$9   ; Compare current block cell address with end address
    BNE BLOCK_LOOP   ; Continue checking cells until end of block is reached

    INC $FE   ; Increment current block start address
    LDX $FE   ; Load current block start address
    CPX #$369   ; Compare current block start address with end address
    BNE VALIDATE_NEXT_BLOCK   ; Continue validating next 3x3 block if not end of board

    RTS

CHECK_VALUE:
    LDA $FC   ; Load value to check
    AND #$F0   ; Mask out lower bits
    CMP #$90   ; Compare with valid values (1-9)
    BEQ VALUE_VALID   ; Value is valid if it matches any of the valid values
    
    LDA $FC   ; Check for 0 which is considered empty cell
    BEQ VALUE_VALID   ; Value is valid if it is 0

    RTS

VALUE_VALID:
    CLC
    RTS
