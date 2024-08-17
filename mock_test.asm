
; 6502 Assembly program to calculate the area of a pyramid
;
; Inputs:
;   Base area - stored in memory location $00-$01 (2 bytes)
;   Height - stored in memory location $02 (1 byte)
; Output:
;   Volume - stored in memory location $03 (2 bytes)

        .org $0200

        LDA $00     ; Load the lower byte of base area
        STA $04     ; Store it in $04
        LDA $01     ; Load the higher byte of base area
        STA $05     ; Store it in $05
        
        LDA $02     ; Load the height
        CLC
        ADC $04     ; Add the lower byte of base area
        STA $06     ; Store the result in $06
        LDA $06
        BCC no_carry ; If no carry, skip the next step
        INC $05      ; Increment the higher byte of base area
no_carry:
        
        LDA $06     ; Load the result
        ASL         ; Multiply it by 2
        TAX         ; Store it in X register
        LDA $04     ; Load the lower byte of base area
        CLC
        ADC $05     ; Add the higher byte of base area
        STA $07     ; Store the result in $07
        
        LDA $07     ; Load the total base area
        STA $8      ; Store it in $08
        
        ; Calculate the volume of the pyramid
        LDX $8      ; Load the total base area
        LDY $02     ; Load the height
        STX $0A     ; Store the total base area in $0A
        TYA         ; Store the height in the Y register
        CLC
        ADC $0A     ; Calculate the volume
        STA $03     ; Store the volume in $03
       
done:
        RTS

        .org $FFFC
        .word start

start:
        JMP done
