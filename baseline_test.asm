
ORG $1000

.data
graph_data:
    .byte 10, 30, 20, 15, 25   ; Data for the bar chart
    .byte 0                    ; Terminating byte

.code
start:
    LDX #0                  ; Initialize index
loop:
    LDA graph_data, X       ; Load data value
    CMP #0                  ; Check for termination
    BEQ done                ; If terminating byte, exit loop
    JSR draw_bar            ; Call subroutine to draw bar
    INX                     ; Increment index
    JMP loop                ; Continue loop

draw_bar:
    LDX #0
    LDA graph_data, X       ; Load data value
    STA $D020               ; Set color
    INX
    LDA graph_data, X       ; Load data value
    STA $D021               ; Set bar height
    STA $D021               ; Set bar height
    STA $D021               ; Set bar height
    STA $D021               ; Set bar height
    STA $D021               ; Set bar height
    STA $D021               ; Set bar height
    STA $D021               ; Set bar height
    STA $D021               ; Set bar height
    STA $D021               ; Set bar height
    RTS

done:
    BRK                     ; Exit program

.end start
