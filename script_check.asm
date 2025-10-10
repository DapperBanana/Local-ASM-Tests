
; Load the CSV data file into memory starting at memory address $1000
    LDX #0
load_data:
    LDA data_file, X
    STA $1000, X
    INX
    CPX #50 ; Assuming there are 50 bytes of data in the CSV file
    BNE load_data

; Initialize sum to 0
    LDA #0
    STA sum

; Parse CSV data and calculate sum
parse_data:
    LDA $1000, X
    CMP #44 ; Check if current byte is a comma (ASCII code 44)
    BEQ next_value
    CMP #10 ; Check if current byte is a newline (ASCII code 10)
    BEQ end_of_data
    CLC
    ADC #48 ; Convert ASCII digit to actual number
    TAX
    ADC sum
    STA sum
    INX
    JMP parse_data

next_value:
    INX
    JMP parse_data

end_of_data:
    ; Now the sum of all numbers in the CSV file is stored in the 'sum' variable

data_file:
    .asc "1,2,3,4,5,6,7,8,9,10"
