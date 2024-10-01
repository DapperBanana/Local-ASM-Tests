
; Find the union of two sets

; Set 1: {1, 2, 3, 4, 5}
set1   .byte   1, 2, 3, 4, 5

; Set 2: {3, 4, 5, 6, 7}
set2   .byte   3, 4, 5, 6, 7

; Union of the sets
union  .byte   0, 0, 0, 0, 0, 0, 0

        CLD       ; Clear decimal mode
        LDX  #5   ; Set loop counter
loop    LDA  set1,X  ; Load value from set 1
        STA  union,X  ; Store in union set
        LDA  set2,X  ; Load value from set 2
        ORA  union,X  ; Logical OR with union set value
        STA  union,X  ; Store in union set
        DEX        ; Decrement loop counter
        BPL  loop  ; Repeat until all elements processed

        NOP        ; End of program

        .END
