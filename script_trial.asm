
; 6502 Assembly Educational Quiz

        .org $0200

START   lda #0          ; Set accumulator to 0
        sta $f0         ; Initialize score counter
        lda #questions  ; Load address of the first question
        sta $f1         ; Store it in memory
        lda #answers    ; Load address of the first answer
        sta $f2         ; Store it in memory

LOOP    lda $f1         ; Load address of current question
        jsr $ffd2       ; Print question to screen
        lda $f2         ; Load address of current answer
        jsr $ffd2       ; Print answer choices to screen

        lda $f2         ; Load address of current answer
        lda $f3         ; Load input answer
        cmp $f3         ; Compare input answer to correct answer
        beq CORRECT     ; If equal, branch to CORRECT
        bne INCORRECT   ; If not equal, branch to INCORRECT

CORRECT ; Increment score
        inc $f0
        jmp NEXT

INCORRECT ; Incorrect message
        lda #incorrect_message
        jsr $ffd2

NEXT    lda $f1         ; Load address of next question
        clc
        adc #2          ; Move to next question
        sta $f1         ; Store it in memory

        lda $f2         ; Load address of next answer
        clc
        adc #3          ; Move to next answer
        sta $f2         ; Store it in memory

        lda $f1         ; Load address of next question
        cmp #end         ; Compare to end address
        beq END         ; If end of questions, branch to END

        lda $f2         ; Load address of next answer
        jmp LOOP

END     lda #final_score
        jsr $ffd2

        lda $f0         ; Load final score
        jsr $ffd2

        rts             ; Return from subroutine

questions .byte "What is the capital of France?", $00
answers   .byte "A. London B. Paris C. Berlin D. Rome", $00
          .byte "B" ; Correct answer

incorrect_message .byte "Incorrect answer. Try again.", $00
final_score      .byte "Your final score is: ", $00
end      .byte $00

        .org $fffa
        .word START
