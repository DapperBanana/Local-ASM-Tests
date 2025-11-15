
ORG $0600        ; Load program at address $0600

LDA #$00         ; Initialize accumulator to 0
STA result       ; Store result in result variable

LDA base_area
STA $00          ; Store base area in memory location $00

LDA height
STA $01         ; Store height in memory location $01

LDA $01
CLC
ADC $00          ; Add base area to height
ASL              ; Multiply the sum by 2
TAX              ; Transfer result to X register
LDA $00
ASL              ; Multiply base area by 2
CLC
ADC $00           ; Add base area to itself
ADC $01           ; Add height
TAY              ; Transfer result to Y register

TXS              ; Transfer result to stack pointer

JMP $FFFC       ; Jump to end of program

result DS 1     ; Declare variable to store result

base_area DC 10 ; Define base area
height DC 5    ; Define height
