
; Program to calculate the median of a list of numbers

        .org $0200      ; Start program at address $0200

        LDX #NUMBERS    ; Load X with address of list of numbers
        LDY #NUMBERS+1  ; Load Y with address of next number
        LDAB #$07       ; Load B with number of elements to sort

SORT_LOOP:
        LDA ,(X)        ; Load element pointed to by X into A
        PSHB            ; Push B onto the stack
        PSHA            ; Push A onto the stack
        
        LDA ,(Y)        ; Load element pointed to by Y into A
        CLRA            ; Clear A
        ASLA            ; Multiply by 2
        ADC ,X          ; Add X
        STA TEMP        ; Store result in TEMP
        
        PULA            ; Pop A from the stack
        PULB            ; Pop B from the stack
        DECA            ; Decrement B
        BNE SORT_LOOP   ; If B is not zero, loop back

        LDX #TEMP       ; Load X with address of temp
        LDAB #$00       ; Load B with number of elements
        LDA ,(X)        ; Load element pointed to by X into A
    
MEDIAN_LOOP:
        INX             ; Increment X
        ADDA ,(X)       ; Add element pointed to by X to A
        DECA            ; Decrement A
        BHI MEDIAN_LOOP ; If A is greater than zero, loop back
        
        DECA            ; Decrement A
        BNE MEDIAN_LOOP ; If A is not zero, loop back

        LDX #RESULT     ; Load X with address of result
        STA ,(X)        ; Store median in RESULT

        SWI             ; End program

NUMBERS DFB $03,$07,$01,$05,$09,$02,$08
TEMP    FCB $00
RESULT  FCB $00

        .end
