
ORG $1000

START:
    LDA #0       ; initialize variables
    STA index
    LDA valToSearch
    STA searchValue
    LDX #0       ; initialize low index
    LDA #7       ; initialize high index
    STA highIndex

SEARCH_LOOP:
    CMP X, highIndex  ; compare low and high index
    BCC NOT_FOUND     ; if low index is greater than high index, search value not found
    
    LDA highIndex     ; calculate mid index
    SEC
    SBC X
    LSR
    STA midIndex
    
    LDX midIndex
    LDA sortedList,X   ; get middle value from sorted list
    
    CMP A, searchValue   ; compare middle value with search value
    BCS GREATER_THAN     ; if middle value is greater than search value, update high index
    BCC LESS_THAN        ; if middle value is less than search value, update low index
    
FOUND:
    LDA midIndex
    STA index
    JMP END
    
GREATER_THAN:
    LDA midIndex
    STA highIndex
    JMP SEARCH_LOOP
    
LESS_THAN:
    LDA midIndex
    CLC
    ADC #1
    STA X
    JMP SEARCH_LOOP
    
NOT_FOUND:
    LDA #255    ; indicate search value not found
    STA index
    JMP END
    
END:
    BRK

valToSearch: .BYTE 5
sortedList:  .BYTE 1, 2, 3, 4, 5, 6, 7, 8
index:       .BYTE
searchValue: .BYTE
lowIndex:    .BYTE
highIndex:   .BYTE
midIndex:    .BYTE

    END START
