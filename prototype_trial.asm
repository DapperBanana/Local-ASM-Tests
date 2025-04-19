
        .org $2000

start   LDX #$0            ; Initialize index
        STX current        ; Store current Fib number
        LDX #$1            ; Initialize next Fib number
        STX next           ; Store next Fib number
        
        LDA #10            ; Number of terms to generate
        STA count

loop    LDA current       ; Load current Fib number
        STA temp          ; Store in temp
        
        CLC
        LDA current       ; Load current Fib number
        ADC next          ; Add next Fib number
        STA current       ; Store as new current Fib number
        
        LDA temp          ; Load temp (previous current)
        STA next          ; Store as new next Fib number
        
        STA ($0200),Y     ; Store Fib number in memory
        
        INY               ; Increment index
        DEX               ; Decrement count
        BNE loop          ; Repeat until count is zero
        
        RTS

current .byte $00         ; Current Fib number
next    .byte $00         ; Next Fib number
temp    .byte $00         ; Temporary storage for current Fib number

count   .byte $00         ; Number of terms to generate

        .org $3000
        .res 10

        .end start
