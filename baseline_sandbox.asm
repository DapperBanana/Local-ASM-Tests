
        .org $0200

start   lda InputStr1
        sta Str1Ptr
        lda InputStr2
        sta Str2Ptr

        ldx #0              ; Initialize distance to 0
        lda #0              ; Initialize index i to 0
        sta LoopCounter1
        sta LoopCounter2

compareLoop
        lda (Str1Ptr),x     ; Load character from 1st string
        cmp #0              ; Check for null terminator
        beq endLoop         ; If reached end of string, exit loop

        pha                 ; Save character onto stack
        lda (Str2Ptr),x     ; Load character from 2nd string
        cmp #0              ; Check for null terminator
        beq endLoop         ; If reached end of string, exit loop

        pla                 ; Restore character from stack
        cmp (Str2Ptr),x     ; Compare characters
        beq incLoopCounter  ; If characters match, increment loop counter

        inc x               ; Otherwise, increment edit distance
        inc EditDistance
        jmp compareLoop

incLoopCounter
        inc LoopCounter1    ; Increment 1st string index
        inc LoopCounter2    ; Increment 2nd string index
        jmp compareLoop

endLoop lda EditDistance  ; Load edit distance value
        sta Result         ; Store result in Result variable

done    jmp done

InputStr1 .text "HELLO",0
InputStr2 .text "HELL",0
Str1Ptr .byte 0
Str2Ptr .byte 0
EditDistance .byte 0
Result .byte 0

        .end
