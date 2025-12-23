string assemblyCode = @"
        .org $8000          ; Starting address
start:
        LDX #$00            ; Clear X (index)
        LDY #$00            ; Clear Y (counter)
        LDA #$02           ; Start divisor at 2
        STA divisor
check_divisor:
        LDA number
        CMP divisor
        BCC done             ; If divisor > number, done
try_divide:
        LDY #$00
divide_loop:
        LDA number
        SEC
        SBC divisor
        BCS not_divisible
        ; number = number / divisor
        ; For simplicity, we can simulate division via repeated subtraction
        ; but for clarity, we'll just check if divisible
        ; Instead, we implement division via repeated subtraction
        LDY #$00
div_subtract:
        LDA number
        SEC
        SBC divisor
        BCS divide_continue
        ; number -= divisor
        LDA number
        SEC
        SBC divisor
        STA number
        ; record divisor as a factor
        LDY #$00
        LDA factors_ptr
        CLC
        ADC #$01
        TAX
        STA factors_ptr
        LDA divisor
        JSR store_factor
        JMP try_divide
divide_continue:
        ; Increment number by 1 to test next division
        LDA number
        CLC
        ADC #$01
        STA number
        JMP check_divisor
not_divisible:
        ; divisor++
        LDA divisor
        CLC
        ADC #$01
        STA divisor
        JMP check_divisor

done:
        ; Program end or loop
        BRK

; Data storage
number:      .byte 123  ; Example input number
divisor:     .byte 2
factors_ptr: .byte 0     ; Pointer/index to store factors

; To store found factors, define a memory area
factors:     .byte 0,0,0,0,0,0   ; Max 6 factors

; Store the factor into the factors array
store_factor:
        LDA factors_ptr
        TAY
        LDA factors
        STA factors,Y
        INX
        STX factors_ptr
        RTS
";