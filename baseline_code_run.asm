
* Set up memory locations for input and output
X1      .equ    $FB     ; Base length of the pentagonal prism
Y1      .equ    $FC     ; Side length of the pentagon
ANSWER  .equ    $FD     ; Area of the pentagonal prism

* Set up program start
START   LDY     #$00    ; Initialize Y register to zero
        LDA     #10     ; Load 10 into A register
        STA     X1      ; Store 10 in X1 memory location
        LDA     #6      ; Load 6 into A register
        STA     Y1      ; Store 6 in Y1 memory location

* Calculate the area of the pentagonal prism
CALC    LDA     X1      ; Load base length into accumulator
        STA     $FA     ; Store base length in temporary memory location
        LDA     Y1      ; Load side length into accumulator
        STA     $FB     ; Store side length in temporary memory location
        
        LDA     $FA     ; Reload base length into accumulator
        ASL             ; Multiply by 2 to get perimeter of base
        ASL
        ASL
        STA     $FC     ; Store perimeter of base in temporary memory location
        
        LDA     $FB     ; Reload side length into accumulator
        STA     $FD     ; Store side length in temporary memory location
        
        LDA     $FC     ; Load perimeter of base into accumulator
        STA     $FE     ; Store perimeter of base in temporary memory location
        
        LDA     $FD     ; Load side length into accumulator
        ADC     $FE     ; Add perimeter of base to side length
        STA     $FF     ; Store total perimeter of prism in temporary memory location
        
        LDA     $FF     ; Load total perimeter of prism into accumulator
        STA     X1      ; Store total perimeter of prism in X1 memory location
        
        LDA     X1      ; Reload total perimeter of prism into accumulator
        SEC             ; Set carry flag
        SBC     $FA     ; Subtract base length from total perimeter
        TAY             ; Transfer result to Y register
        
        LDA     X1      ; Reload total perimeter of prism into accumulator
        ADC     Y1      ; Add side length to total perimeter
        TAX             ; Transfer result to X register
        
        LDA     X1      ; Load total perimeter of prism into accumulator
        TAX             ; Transfer result to X register
        TYA             ; Transfer result to A register
        
        ASL             ; Multiply result by 1/2
        ASL
        ASL
        STA     ANSWER  ; Store area of pentagonal prism in ANSWER memory location
        
* End the program
DONE    NOP             ; No operation
        JMP     DONE    ; Loop indefinitely
