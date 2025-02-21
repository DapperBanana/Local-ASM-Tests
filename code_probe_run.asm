
; Constants
X1 = $00  ; x coordinate of first point
Y1 = $01  ; y coordinate of first point
Z1 = $02  ; z coordinate of first point
X2 = $03  ; x coordinate of second point
Y2 = $04  ; y coordinate of second point
Z2 = $05  ; z coordinate of second point

; Variables
result = $06  ; variable to store the result
temp = $07    ; temporary variable

start:
    LDA X1      ; load x coordinate of first point
    STA temp    ; store in temporary variable
    LDA X2      ; load x coordinate of second point
    SEC
    SBC temp    ; subtract x2 - x1
    ASL         ; multiply by 2
    STA result  ; store in result variable

    LDA Y1
    STA temp
    LDA Y2
    SEC
    SBC temp
    ASL
    CLC
    ADC result  ; add to result

    ; calculate (z2-z1)^2
    LDA Z1
    STA temp
    LDA Z2
    SEC
    SBC temp
    STA result
    ASL
    CLC
    ADC result

    ; calculate square root of result
    LDX #$00     ; initialize loop counter
sqrt_loop:
    LDY result  ; load current result
    LSR         ; divide by 2
    STA result  ; store new result
    CPY result  ; compare current result with previous result
    BCC sqrt_end  ; if the result did not change, exit loop
    INX         ; increment loop counter
    CPX #4      ; check if loop counter reached limit
    BNE sqrt_loop

sqrt_end:
    ; final result is in result variable, can be used further

end:
    BRK         ; end of program
