// Note: This C# code demonstrates how to generate a 6502 assembly program that performs grayscale conversion
// on image pixel data. It outputs the assembly source as a string.

string Generate6502AssemblyForGrayscale()
{
    return @"
; 6502 Assembly for converting an image to grayscale
; Assumptions:
; - Pixels are in RGB format, 3 bytes per pixel: R, G, B
; - Image data starts at 'IMAGE_START'
; - Image size (number of pixels) is at 'PIXEL_COUNT'
; - Result overwrites original data

        .org $8000

IMAGE_START   = $0200      ; Starting address of image data
PIXEL_COUNT   = $0100      ; Number of pixels (256 pixels)

        LDX #0             ; Pixel index

    LOOP:
        CPX #PIXEL_COUNT
        BEQ DONE

        ; Load R, G, B values
        LDA IMAGE_START, X        ; Load Red
        STA R_VAL
        LDA IMAGE_START, X+1      ; Load Green
        STA G_VAL
        LDA IMAGE_START, X+2      ; Load Blue
        STA B_VAL

        ; Compute luminance: Y = 0.299*R + 0.587*G + 0.114*B
        ; We'll approximate with integer math:
        ; Y = (77 * R + 150 * G + 29 * B) >> 8

        LDA R_VAL
        BEQ SKIP

        ; Multiply R by 77
        LDA R_VAL
        ASL
        CLC
        ADC R_VAL
        ASL
        ADC R_VAL
        ADC R_VAL
        TO_DECIMAL 77, R_temp

        ; Multiply G by 150
        LDA G_VAL
        CLC
        ADC G_VAL
        ADC G_VAL
        ADC G_VAL
        ADC G_VAL
        ADC G_VAL
        ADC G_VAL
        TO_DECIMAL 150, G_temp

        ; Multiply B by 29
        LDA B_VAL
        CLC
        ; For simplicity, multiply B by 29 via repeated addition
        ; (Alternatively, precompute or approximate)
        STA B_MULT
        LDA B_VAL
        SEI
        ; Compute B * 29
        ; B * 29 = B * (16 + 8 + 4 + 1)
        ; So we do B*16 + B*8 + B*4 + B
        ; B*16
        LDA B_VAL
        ASL
        ASL
        ASL
        ADC B_VAL     ; B*16
        STA B16
        ; B*8
        LDA B_VAL
        ASL
        ASL
        ADC B_VAL
        STA B8
        ; B*4
        LDA B_VAL
        ASL
        ASL
        STA B4
        ; Sum all
        LDA B16
        CLC
        ADC B8
        ADC B4
        ADC B_VAL            ; B*1
        TAX
        LDA #29
        STA B_TEMP

        ; Sum all parts
        LDA R_temp
        CLC
        ADC G_temp
        ADC B_temp

        ; Divide sum by 256 (shift right 8 bits)
        ; For approximation, just shift right 8 bits (i.e., ignore fractional part)
        ; But since we want to set the pixel to grayscale R=G=B=Y
        ; We can just take the high byte of the sum
        ; Alternatively, sum is less than 255*3, so handle accordingly
        ; For simplicity, let's just store the sum as Y
        ; and set R, G, B to Y

        ; Store Y
        STA Y_VAL

        ; Overwrite pixel with grayscale
        LDA Y_VAL
        STA IMAGE_START, X
        LDA Y_VAL
        STA IMAGE_START, X+1
        LDA Y_VAL
        STA IMAGE_START, X+2

        ; Increment X by 3 bytes per pixel
        INX
        INX
        INX

        JMP LOOP

    SKIP:
        INX
        INX
        INX
        JMP LOOP

    DONE:
        RTS

; Data storage
R_VAL     .byte 0
G_VAL     .byte 0
B_VAL     .byte 0
Y_VAL     .byte 0
B16       .byte 0
B8        .byte 0
B4        .byte 0
B_TEMP    .byte 0
R_temp    .byte 0
G_temp    .byte 0
B_temp    .byte 0
";
}

// Usage:
string assemblyCode = Generate6502AssemblyForGrayscale();
Console.WriteLine(assemblyCode);