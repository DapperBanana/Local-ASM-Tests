
ORG $1000

start:
    LDA #0         ; Initialize accumulator
    STA count
    LDA #0         ; Initialize pointer to source data
    STA source_ptr

    LDA #$20       ; Start address of source data
    STA source

    LDA #$40       ; Start address of destination data
    STA dest

encode_loop:
    LDA source_ptr
    CMP #$FF       ; Check if end of data
    BEQ end_encode

    LDA source_ptr
    STA current_ptr

    LDA source_ptr
    STA next_ptr
    CLC
    ADC #1
    STA next_ptr

    LDA (current_ptr),Y
    STA current_char

    LDA (next_ptr),Y
    CMP current_char
    BEQ increase_count

    LDA dest
    STA dest_ptr

    LDA count
    CMP #$01
    BEQ encode_single_char

    STA (dest_ptr),Y  ; Store count
    INC dest_ptr
    STA (dest_ptr),Y  ; Store character

encode_single_char:
    LDA #$01
    STA (dest_ptr),Y  ; Store count
    INC dest_ptr
    LDA current_char
    STA (dest_ptr),Y  ; Store character

    LDA source_ptr
    LDX #2
    CLC
    ADC X
    STA source_ptr
    JMP encode_loop

increase_count:
    INC count
    JMP encode_loop

end_encode:
    RTS

source:
    .BYTE $41,$41,$41,$41,$42,$42,$42,$43,$43,$43

dest:
    .BYTE 0,0,0,0,0,0,0,0,0,0,0,0

count:
    .BYTE 0

source_ptr:
    .BYTE 0

current_ptr:
    .BYTE 0

next_ptr:
    .BYTE 0

dest_ptr:
    .BYTE 0

current_char:
    .BYTE 0
