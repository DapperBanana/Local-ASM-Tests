
RESET      = $FFFC
IRQ_VECTOR = $FFFE

SEI         = $78
CLI         = $58
CLD         = $D8
SEC         = $38
CLC         = $18
LDA_IMM     = $A9
STA_ABS     = $8D
STA_ZP      = $85
LDX_IMM     = $A2
STX_ZP      = $86
JSR_ABS     = $20
BEQ         = $F0
BNE         = $D0
CMP_IMM     = $C9
CMP_ZP      = $C5
CMP_ABS     = $CD
ASL         = $0A
LSR         = $4A
TAX         = $AA
TXA         = $8A
INX         = $E8
INY         = $C8
BPL         = $10
BYTE        = $00

BUFFER      = $0200
VALID_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&'*+-/=?^_`{|}~.@"
EMAIL_END   = $00

ORG $0200

Main:
    LDX_IMM #$00                 ; Initialize index
    LDY_IMM #$01                 ; Initialize string length
    LDA_IMM BUFFER               ; Load the first byte of the string into the accumulator
    BEQ InvalidEmail             ; Branch if the string is empty

CheckChar:
    CMP_IMM EMAIL_END            ; Check if we reached the end of the string
    BEQ ValidEmail               ; Branch if end of string reached

    LDA_ABS VALID_CHARS,X        ; Load the current valid character set into the accumulator
    BNE CheckNextChar            ; Branch if the current character is not valid
    
    INX                          ; Increment index
    INY                          ; Increment string length
    BNE CheckChar                ; Check next character

CheckNextChar:
    INX                          ; Increment index
    BNE CheckChar                ; Check next character

ValidEmail:
    LDX_IMM #$01                 ; Set X register to 1 to indicate valid email address
    BRK

InvalidEmail:
    LDX_IMM #$00                 ; Set X register to 0 to indicate invalid email address
    BRK

ORG IRQ_VECTOR
    WORD RESET

ORG RESET
    SEI                          ; Disable interrupt
    CLD                          ; Set Decimal mode off
    LDX_IMM #$00                 ; Initialize X register
    STX_ZP BUFFER                ; Clear buffer
    STX_ZP EMAIL_END             ; Initialize end of string marker
    CLI                          ; Enable interrupt
    RTS                          ; Return from subroutine

ORG $FFFE
    WORD Main                    ; Set interrupt vector to Main

END Main
