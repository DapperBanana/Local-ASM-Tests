
        ORG     $0200

START   LDX     #00             ; Initialize accumulator to 0
        LDY     #00             ; Initialize second operand to 0
        STX     ACCUMULATOR     ; Store accumulator in memory
        STY     OPERAND         ; Store second operand in memory
        
        ; Get user input for operation
INPUT   LDA     #0
        JSR     $FFEF           ; Input operation
        STA     OPERATION       ; Store operation in memory
        
        ; Get user input for second operand
        JSR     $FFEF           ; Input operand
        STA     OPERAND         ; Store operand in memory
        
        ; Perform selected operation
        LDA     OPERATION
        CMP     #1              ; Check if addition operation
        BEQ     ADDITION
        
        CMP     #2              ; Check if subtraction operation
        BEQ     SUBTRACTION
        
        CMP     #3              ; Check if multiplication operation
        BEQ     MULTIPLICATION
        
        CMP     #4              ; Check if division operation
        BEQ     DIVISION
        
        ; Invalid operation
INVALID LDA     #65
        JSR     $FFD2           ; Output error message
        JMP     START           ; Restart program
        
ADDITION LDA     OPERAND        ; Load second operand
        CLC
        ADC     ACCUMULATOR    ; Add to accumulator
        STA     ACCUMULATOR    ; Store result in accumulator
        JMP     OUTPUT          ; Output result
        
SUBTRACTION LDA    OPERAND      ; Load second operand
        SEC
        SBC    ACCUMULATOR     ; Subtract from accumulator
        STA    ACCUMULATOR     ; Store result in accumulator
        JMP    OUTPUT           ; Output result
        
MULTIPLICATION LDA    OPERAND   ; Load second operand
        CLC
        ADC    #0             ; Clear accumulator
        ASL                    ; Multiply by 2
        TAX                    ; Save result in X register
        LDA    OPERAND         ; Load second operand
        JSR    $47D2           ; Multiply by X
        STA    ACCUMULATOR     ; Store result in accumulator
        JMP    OUTPUT          ; Output result
        
DIVISION LDA    OPERAND         ; Load second operand
        CLC
        ADC    #0              ; Clear accumulator
        JSR    $4824            ; Divide accumulator by operand
        STA    ACCUMULATOR      ; Store result in accumulator
        JMP    OUTPUT           ; Output result
        
OUTPUT  LDA     ACCUMULATOR    ; Load result from accumulator
        JSR     $FFEE           ; Output result
        JMP     START           ; Restart program

ACCUMULATOR DS 1                ; Accumulator variable
OPERAND     DS 1                ; Second operand variable
OPERATION   DS 1                ; Operation variable

        END     START
