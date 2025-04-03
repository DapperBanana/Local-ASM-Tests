
; Load data into memory
LDA data1     ; Load first data value
STA $0200     ; Store it at memory location $0200

LDA data2     ; Load second data value
STA $0201     ; Store it at memory location $0201

LDA data3     ; Load third data value
STA $0202     ; Store it at memory location $0202

; Draw bar chart
LDA #$FF      ; Load fill value for bars
STA $0300     ; Store it at memory location $0300

LDA #$00
STA $0301
STA $0302

LDA $0200     ; Load first data value
JSR draw_bar  ; Draw bar for first data value

LDA $0201     ; Load second data value
JSR draw_bar  ; Draw bar for second data value

LDA $0202     ; Load third data value
JSR draw_bar  ; Draw bar for third data value

; Halt program
BRK

; Subroutine to draw a bar
draw_bar:
    LDY #$00
loop:
    LDA $0300
    LDX $0301
    STA $0200, Y
    INY
    CPY $0200
    BNE loop
    JMP exit

exit:
    RTS

; Data section
data1 .BYTE 5    ; Data value 1
data2 .BYTE 3    ; Data value 2
data3 .BYTE 7    ; Data value 3

.END
