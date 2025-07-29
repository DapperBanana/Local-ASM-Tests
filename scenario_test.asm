
    LDA variable1    ; Load value of variable1 into the A register
    STA temp         ; Store value of variable1 in temp
    LDA variable2    ; Load value of variable2 into the A register
    STA variable1    ; Store value of variable2 in variable1
    LDA temp         ; Load value of variable1 from temp into the A register
    STA variable2    ; Store value of variable1 in variable2

variable1 .byte 10    ; Initialize variable1 with value 10
variable2 .byte 20    ; Initialize variable2 with value 20
temp .byte 0         ; Temporary variable to store value

    END
