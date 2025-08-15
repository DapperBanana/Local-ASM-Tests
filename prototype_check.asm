
ORG $1000

LDX #$00
LDY #$00

; Get the base and top lengths of the trapezoid
LDX #base_length
JSR get_input

LDX #top_length
JSR get_input

; Get the height of the trapezoid
LDX #height
JSR get_input

; Calculate the area of the trapezoid
LDA base_length
CLC
ADC top_length
TAX

LDA height
CLC
ADC height
TAY

LDX base_length
STX result

; Multiply the base+top length by height and divide by 2
JSR multiply
ASL result
ASL result

; Store the final result in the Y register
TAY

; Halt the program
BRK

get_input:
    LDA #$00
    STA input
    LDA #$00
    STA input + 1

    JSR read_input

    LDA input
    STA (X)

    RTS

read_input:
    LDX #$00
loop:
    JSR read_char

    CMP #$0D
    BEQ done

    CMP #$30
    BCC loop

    CMP #$39
    BCS loop

    STA temp
    LDA input
    ASL
    ASL
    ASL
    ASL
    CLC
    ADC temp
    STA input

    JMP loop

done:
    RTS

read_char:
    LDA #$FF
    STA temp
    JSR $FFCF

    CMP #$08
    BNE skip_backspace

    LDA #$20
    STA input,X
    BMI no_decrement
    DEC X
no_decrement:

    JSR $FFD2

    JMP read_char

skip_backspace:
    CMP #$0D
    BEQ line_feed

    LDA temp
    STA input, X
line_feed:
    RTS

multiply:
    LDA #$00
    STA product

multiply_loop:
    ASL result
    ADC top_length
    STA result

    DEC Y
    BNE multiply_loop

    RTS

product:
    .BYTE $00, $00
input:
    .BYTE $00, $00, $00
temp:
    .BYTE $00
base_length:
    .BYTE $00
top_length:
    .BYTE $00
height:
    .BYTE $00
result:
    .BYTE $00, $00

