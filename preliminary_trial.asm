
        ; Roman numeral to integer conversion program

start   lda #0              ; Initialize accumulator to 0
        sta sum
        lda #0              ; Initialize index to 0
        sta index

loop    lda romans,x       ; Load current Roman numeral character
        beq done           ; If end of string, jump to done
        tax                ; Transfer character to X register
        lda values,x       ; Load corresponding value
        clc
        adc sum            ; Add value to total sum
        sta sum            ; Store updated sum
        inx                ; Increment index
        bne loop           ; Repeat loop

done    ; Program done, sum contains converted integer value

romans  .text "XIV"
values  .byte 10,1,5,0

        .end
