
START:
    LDX #0          ; Initialize index to 0
    LDY #0          ; Initialize max element to 0

LOOP:
    LDA NUMBERS, X  ; Load element at index X
    CMP Y           ; Compare with current max element
    BCC NOT_MAX     ; Branch if current element is not greater
    STA Y           ; Update max element
NOT_MAX:
    INX             ; Increment index
    CPX #10         ; Check if end of list
    BNE LOOP        ; Loop until end of list

END:
    NOP             ; End of program

NUMBERS:
    .byte 12, 34, 56, 78, 23, 45, 67, 89, 9, 99  ; List of numbers
