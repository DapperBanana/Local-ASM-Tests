
FRUSTUM_HEIGHT    = $10      ; Height of Frustum
FRUSTUM_RADIUS_1  = $12      ; Bottom Radius of Frustum
FRUSTUM_RADIUS_2  = $14      ; Top Radius of Frustum
PI_VALUE          = $3.14159 ; Value of Pi

SECTOR_AREA EQU $100

START       LDX #FRUSTUM_RADIUS_1  ; Load bottom radius of frustum
            LDY #FRUSTUM_RADIUS_2  ; Load top radius of frustum
            LDA #FRUSTUM_HEIGHT    ; Load height of frustum
            JSR CALCULATE_AREA     ; Call subroutine to calculate the area of frustum
            BRK                    ; End of program

CALCULATE_AREA
            STX $00                ; Store bottom radius in memory location $00
            STY $01                ; Store top radius in memory location $01
            STA $02                ; Store height in memory location $02

            LDA $00
            STA SECTOR_AREA        ; Save bottom radius for calculation
            LDA $01
            STA SECTOR_AREA+1      ; Save top radius for calculation
            LDA $02
            STA SECTOR_AREA+2      ; Save height for calculation

            ; Calculate area of frustum
            LDY SECTOR_AREA        ; Load bottom radius
            STY $03                ; Store it in memory location $03
            LDY SECTOR_AREA+1      ; Load top radius
            STY $04                ; Store it in memory location $04
            LDY SECTOR_AREA+2      ; Load height
            STY $05                ; Store it in memory location $05

            ; Calculate the surface area of frustum
            LDX $03                ; Load bottom radius to X register
            LDA $03
            CLC
            ADC $04                ; Calculate radius sum and store in accumulator
            STA $06

            ; Calculate area
            JSR MULTIPLE_PI        ; Call subroutine to multiply by Pi
            STA $08                ; Store the value in memory location $08

            LDX $05                ; Load height to X register
            LDA $06
            STA $07                ; Store the value in memory location $07

            LDA $07
            SEC
            ADC $08                ; Calculate final result
            RTS                    ; Return from subroutine

MULTIPLE_PI
            LDA #$CE               ; Load high byte of Pi
            STA $0A
            LDA #$2D               ; Load low byte of Pi
            STA $0B

            LDX $06
            LDY $0A
            STA $0C

            LDX $07
            LDY $0B
            STA $0D

            LDA $0C
            LDY $0D
            CLC
            ADC $0C
            STA $0E

            LDX $0C
            LDA $0D
            STA $0F

            RTS
