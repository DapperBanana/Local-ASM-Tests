
    .text
    .globl _start

_start:
    LDA #10     ; load the radius of the cone
    STA radius

    LDA #5      ; load the height of the cone
    STA height

    JSR calculate_volume  ; call the calculate_volume subroutine

    LDA volume  ; load the calculated volume into the accumulator
    ; the result is now stored in the accumulator and can be used as needed

    BRK  ; end of program

calculate_volume:
    LDA radius  ; load the radius of the cone into the accumulator
    STA temp    ; store the radius in a temporary variable

    LDA height  ; load the height of the cone into the accumulator
    STA radius  ; store the height in the radius variable

    LDA temp    ; load the radius back into the accumulator
    JSR calculate_area  ; call the calculate_area subroutine to calculate the base area
    
    LDA area  ; load the calculated base area into the accumulator
    ADC temp  ; add the radius to the base area
    STA temp   ; store the result in the temporary variable
    
    LDA #3     ; load the constant 3
    STA volume  ; store it in the volume variable as a temporary value

    LDA temp   ; load the result of the previous calculation back into the accumulator
    STA radius ; store it back in the radius variable

    JSR calculate_area  ; call the calculate_area subroutine again to calculate the slant height

    LDA area   ; load the calculated slant height into the accumulator
    ADC radius ; add the radius to the slant height
    ASL  ; multiply the result by 2 (shift left)
    STA temp; store the result back in the temporary variable

    LDA temp  ; load the result of the previous calculation back into the accumulator
    JSR multiply  ; call the multiply subroutine to multiply it by the volume variable

    RTS  ; return from the calculate_volume subroutine

calculate_area:
    LDA radius ; load the radius into the accumulator
    INY       ; increase Y register for the temporary storage of the radius
    STA (ZP),Y ; store the radius in the zero page memory
    DEY       ; decrease Y register to get the zero page memory address

    LDA temp   ; load the height into the accumulator
    JSR multiply  ; call the multiply subroutine to multiply the radius and height

    STA area   ; store the calculated area in the area variable
    
    LDA (ZP),Y ; load the stored radius back from the zero page memory
    DEY       ; decrease Y register for cleanup

    RTS  ; return from the calculate_area subroutine

multiply:
    STX temp1  ; store the first argument in the temporary storage
    LDY #0     ; clear the Y register

multiply_loop:
    LDA temp1  ; load the first argument into the accumulator
    CLC
    ADC temp2  ; add the second argument
    STA temp1  ; store the result back in the temporary storage
    DEY        ; decrease Y register
    BNE multiply_loop ; loop until Y reaches 0

    LDX temp1  ; load the final result into the X register
    RTS  ; return from the multiply subroutine

    .bss
    temp: .byte 0
    area: .byte 0
    radius: .byte 0
    volume: .byte 0
    temp1: .byte 0
    temp2: .byte 0
    ZP: .byte 0
