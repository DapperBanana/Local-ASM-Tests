
; Edit Distance Calculation Program

        .org    $0200  ; Set starting memory address

        .array1 .byte   "kitten"
        .array2 .byte   "sitting"
        
        LDA     #$00    ; Initialize counter to 0
        STA     counter ; Store counter in memory

loop:
        LDA     counter 
        CMP     #6      ; Compare counter to length of first string
        BEQ     done    ; If counter equals length of string, exit loop

        LDA     #0
        STA     j
loop2:
        LDA     counter
        CMP     #7      ; Compare counter to length of second string
        BEQ     next    ; If equals, proceed to next iteration

        LDA     j
        CMP     #7      ; Compare j to length of second string
        BEQ     increment_j
        
        LDA     counter 
        CMP     j
        BEQ     next2
        
        LDA     #1
        STA     cost
        JMP     calc
        
increment_j:
        LDA     j
        CLC
        ADC     #1      ; Increment j
        STA     j
        JMP     loop2
        
next2:
        LDA     #1
        STA     cost
        JMP     calc
        
next:
        LDA     counter 
        CLC
        ADC     #1      ; Increment counter
        STA     counter
        JMP     loop
        
calc:
        LDA     counter 
        CLC
        ADC     j
        STA     index  ; Calculate index in 1D array
        
        LDA     #0
        STA     dist    ; Initialize distance to 0
        
        LDA     cost
        BEQ     copy    ; If cost is 0, no operation needed
        
        LDA     index 
        CLC
        ADC     #7
        STA     index2  ; Calculate index for previous row
        
        LDA     array
        TAX             ; Load address of array into X register
        LDA     index2  ; Load previous row index into A register
        CLC
        ADC     #index  
        TAX
        LDA     index
        ADC     #1
        TAX
        TYA
        TAX
        LDA     index 
        STA     b
        STA     x
        LDA     #0
        STA     c
        
        LDA     #0
        STA     a
        STA     e
        STA     f
        
loop3:
        LDA     x
        LDX     #array
        STA     index
        LDA     [x],y
        CLC
        ADC     #1
        STA     t
        LDY     #array
        LDA     [y],t
        CLC
        ADC     #1
        STA     y
        DEC     b
        BNE     copy
        INW     a
        LDY
        LDA
            
        
copy:
        LDA     index
        INX
        CLC
        ADC     #1      ; Increase index
        STA     index
        BNE     loop3   ; Repeat until all elements are copied
        
done:
        BRK

counter:  .byte   $00
j:        .byte   $00
cost:     .byte   $00
index:    .byte   $00
dist:     .byte   $00

        .end
