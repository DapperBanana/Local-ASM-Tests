
    .org $0200

start:
    LDX #0           ; Initialize X register for loop counter
    LDA #0           ; Initialize accumulator to 0
    STA curr_length  ; Initialize current length counter
    STA max_length   ; Initialize max length counter
    LDA #0           ; Initialize accumulator to 0
    STA curr_num     ; Initialize current number container
    LDA #0           ; Initialize accumulator to 0
    STA prev_num     ; Initialize previous number container

loop:
    LDA numbers,X    ; Load next integer from list into accumulator
    STA curr_num     ; Store integer into current number container

    CMP prev_num     ; Compare current number to previous number
    BEQ increment    ; If consecutive, increase current length counter

    LDA curr_length  ; Load current length counter
    STA max_length   ; Store max length if current length is greater
    STA curr_length  ; Reset current length counter

increment:
    INC curr_length  ; Increase current length counter

    LDA curr_num     ; Store current number into previous number container
    STA prev_num

    INX              ; Increment X register
    CPX #length      ; Compare loop counter to length of list
    BNE loop         ; Continue loop if not at end
    JMP done         ; Jump to done if at end

done:
    ; Result is in max_length

    BRK              ; End program execution

numbers:
    .byte 1, 2, 3, 4, 6, 7, 8, 9  ; List of integers
length:
    .byte 8            ; Length of list

curr_length:
    .byte 0            ; Current length counter
max_length:
    .byte 0            ; Max length counter

prev_num:
    .byte 0            ; Previous number container
curr_num:
    .byte 0            ; Current number container
