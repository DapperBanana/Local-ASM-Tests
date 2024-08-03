
; 6502 Assembly program to convert a number to a Roman numeral

ORG $1000

START LDX #$0    ; Initialize index register
    LDY #$0    ; Initialize counter register
    LDY NUM     ; Load the number to convert into accumulator
    CPY #$1000  ; Check if number is greater than 1000
    BCC ONETHOU ; If not, skip to hundreds
    STA ROMAN,Y ; Store "M" Roman numeral in ROMAN array
    INY         ; Increment counter
    SEC         ; Set carry flag
    SBC #$1000  ; Subtract 1000 from number
    BCC START   ; Loop until number is less than 1000
ONETHOU CPY #$900 ; Check if number is greater than or equal to 900
    BCC FIVEHUN ; If not, skip to five hundred
    STA ROMAN,Y ; Store "C" Roman numeral in ROMAN array
    INY         ; Increment counter
    STA ROMAN,Y ; Store "M" Roman numeral in ROMAN array
    INY         ; Increment counter
    SEC         ; Set carry flag
    SBC #$900   ; Subtract 900 from number
    BCC ONETHOU ; Loop until number is less than 900
FIVEHUN CPY #$500 ; Check if number is greater than or equal to 500
    BCC ONEHUN  ; If not, skip to one hundred
    STA ROMAN,Y ; Store "D" Roman numeral in ROMAN array
    INY         ; Increment counter
    SEC         ; Set carry flag
    SBC #$500   ; Subtract 500 from number
    BCC FIVEHUN ; Loop until number is less than 500
ONEHUN CPY #$100 ; Check if number is greater than or equal to 100
    BCC FIFTY   ; If not, skip to fifty
    STA ROMAN,Y ; Store "C" Roman numeral in ROMAN array
    INY         ; Increment counter
    SEC         ; Set carry flag
    SBC #$100   ; Subtract 100 from number
    BCC ONEHUN  ; Loop until number is less than 100
FIFTY CPY #$50  ; Check if number is greater than or equal to 50
    BCC TEN     ; If not, skip to ten
    STA ROMAN,Y ; Store "L" Roman numeral in ROMAN array
    INY         ; Increment counter
    SEC         ; Set carry flag
    SBC #$50    ; Subtract 50 from number
    BCC FIFTY   ; Loop until number is less than 50
TEN CPY #$10   ; Check if number is greater than or equal to 10
    BCC FIVE    ; If not, skip to five
    STA ROMAN,Y ; Store "X" Roman numeral in ROMAN array
    INY         ; Increment counter
    SEC         ; Set carry flag
    SBC #$10    ; Subtract 10 from number
    BCC TEN     ; Loop until number is less than 10
FIVE CPY #$5    ; Check if number is greater than or equal to 5
    BCC ONE     ; If not, skip to one
    STA ROMAN,Y ; Store "V" Roman numeral in ROMAN array
    INY         ; Increment counter
    SEC         ; Set carry flag
    SBC #$5     ; Subtract 5 from number
    BCC FIVE    ; Loop until number is less than 5
ONE CPY #$1     ; Check if number is greater than 1
    BCC DONE    ; If not, program is done
    STA ROMAN,Y ; Store "I" Roman numeral in ROMAN array
    INY         ; Increment counter
    SEC         ; Set carry flag
    SBC #$1     ; Subtract 1 from number
    BCC ONE     ; Loop until number is less than 1
DONE BRK        ; Exit program

NUM .BYTE 144    ; Number to convert

ROMAN .DS 10     ; Array to store Roman numerals

.END START
