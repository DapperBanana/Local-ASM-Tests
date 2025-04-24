
    .org $1000

start:
    ; Initialize variables
    LDX #0         ; Initialize result to 0
    LDY #0         ; Initialize input variable 1 to 0
    STX result     ; Store result in memory
    STY num1       ; Store input variable 1 in memory

    ; Input first number
    lda #<num1
    ldx #>num1
    jsr get_input

    ; Input operation
    lda #<'+'    ; '+' for addition, '-' for subtraction, '*' for multiplication, '/' for division
    jsr get_operation

    ; Input second number
    lda #<num2
    ldx #>num2
    jsr get_input

    ; Perform operation
    lda operation
    cmp #'+'     ; Check if operation is addition
    beq add      ; If addition, go to addition
    cmp #'-'
    beq sub      ; If subtraction, go to subtraction
    cmp #'*'
    beq mul      ; If multiplication, go to multiplication
    cmp #'/'
    beq div      ; If division, go to division

add:
    lda num1
    clc
    adc num2
    sta result
    jmp end

sub:
    lda num1
    sec
    sbc num2
    sta result
    jmp end

mul:
    lda num1
    clc
    adc num2
    sta result
    jmp end

div:
    lda num1
    sec
    sbc num2
    sta result
    jmp end

get_input:
    jsr $FFEF   ; Routine to get input from user
    sta (indirect),y  ; Store input in memory
    rts

get_operation:
    jsr $FFEF   ; Routine to get operation from user
    sta operation   ; Store operation in memory
    rts

result: .dsb 1     ; Variable to store result
num1: .dsb 1       ; Variable to store input number 1
num2: .dsb 1       ; Variable to store input number 2
operation: .dsb 1  ; Variable to store operation

    .end start
