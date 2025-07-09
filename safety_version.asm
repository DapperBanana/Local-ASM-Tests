
; Calculate the area of a regular polygon
;
; Inputs:
;   X-coordinate of the polygon's center: store at memory address $00
;   Y-coordinate of the polygon's center: store at memory address $01
;   Number of sides of the polygon: store at memory address $02
;   Side length of the polygon: store at memory address $03
;
; Output:
;   Area of the polygon: store at memory address $04 and $05
;

START:
    LDA #$00            ; Initialize sum1 register to 0
    STA $04
    STA $05
    
    LDA $03             ; Load side length into accumulator
    STA $06             ; Store side length in temporary register
    
    LDA $02             ; Load number of sides into accumulator
    STA $07             ; Store number of sides in temporary register
    
LOOP:
    LDA $06             ; Load side length from temporary register
    CLC
    ADC $04             ; Add side length to sum1
    STA $04             ; Store sum1
    BCC ADDI           ; Branch if no carry 
    INC $05             ; Increment upper byte of sum1
ADDI:
    LDA $07             ; Load number of sides from temporary register
    DEC $07             ; Decrease counter for sides
    BNE LOOP            ; Loop until all sides have been added
    
    LDA $07             ; Load number of sides for calculation
    STA $07
    LDA $07             ; Load number of sides to calculate the area
    SEC
    SBC #$01            ; Subtract 1 from number of sides
    STA $07
    
    LDA $07             ; Load the number of sides
    CLC
    ADC $04             ; Add sum1 to itself
    STA $04
    BCC ADDII          ; Branch if no carry
    INC $05             ; Increment the upper byte
ADDII:
    
    LDX $04             ; Load the result
    JSR DIVIDE          ; Call divide function
    LDX $06             ; Load side length
    LDA $04             ; Load result
    STA $08
    STA $09
    JSR MULTIPLY        ; Call multiply function
    LDX $08             ; Load the result before divide
    JSR DIVIDE          ; Call divide function
    
    STA $04             ; Store the area result
    LDX $09
    STA $05             ; Store the area result's upper byte
    
    ; End of program
    JMP END             ; Jump to the end of program
    
; Divide subroutine
DIVIDE:
    LDA $08             ; Load the dividend's low byte
    LDX $09             ; Load the dividend's high byte
    CLC
    LDA $07
    SEC
    SBC #$01            ; Decrease the number of divisions
    STA $07
    BCC ENDIV           ; End of division loop
    ROL
    ROL $08
    ROL $09
    ROL $08
    ROL $09
    BCS DIVIDE
    
ENDIV:
    RTS                 ; Return from subroutine

; Multiply subroutine
MULTIPLY:
    CLC
    LDA $07             ; Load the multiplier into accumulator
    LDX #$00            ; Initialize product low byte to 0
    LDA #$00            ; Initialize product high byte to 0
    
MULTLOOP:
    ASL $08             ; Shift the multiplicand left
    ROL $09
    BCS ADDBYTE        ; If carry flag is set, add multiplicand to low byte
    DEC $07
    BNE MULTLOOP        ; Loop until multiplier reaches 0
    
    RTS                 ; Return from subroutine

ADDBYTE:
    CLC
    LDA $06             ; Load multiplicand
    ADC $08             ; Add multiplicand to product low byte
    STA $08             ; Store product low byte
    BCC ADDII           ; If no carry, skip incrementing high byte
    INC $09             ; Increment product high byte
ADDII:
    JMP MULTLOOP        ; Jump back to multiplication loop

END:
    NOP                 ; End of program

