
; Area of a Regular Hexagon Calculator

        .org    $0600

hexSide .byte   $05      ; Side length of the hexagon
hexArea .byte   $00      ; Area of the hexagon

        LDA     hexSide     ; Load the side length of the hexagon
        STA     hexArea     ; Store it in hexArea for future reference

        LDA     hexSide     ; Load side length into A
        ASL                 ; Multiply by 2 (shift left)
        STA     hexArea     ; Store result in hexArea

        LDA     hexArea     ; Load doubled side length into A
        TAX                 ; Transfer to X register for further calculations

        LDA     hexArea     ; Load doubled side length into A
        CLC                 ; Clear carry
        ADC     hexSide     ; Add original side length
        TAX                 ; Transfer back to X register

        LDA     hexArea     ; Load doubled side length into A
        ASL                 ; Multiply by 2 (shift left)
        ADC     hexSide     ; Add original side length
        STA     hexArea     ; Store result in hexArea

        LDA     hexArea     ; Load final result into A
        TAX                 ; Transfer to X register for final calculation

halt:   JMP     halt        ; End program here

        .end
