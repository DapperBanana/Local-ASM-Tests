
.INCLUDE "nesdoug/asm/nesdoug.asm" ; Include NESDUG library

                .org $8000
                .db $80 ; Map the code to the start of memory (Bank 0)
start:
                ldx #$00       ; Initialize counter for vowels
                ldy #$00       ; Initialize index for string character
                lda #$00       ; Initialize accumulator for comparison

loop:
                lda string,y  ; Load next character in string
                beq finish    ; If end of string, finish counting
                cmp #$41      ; Compare with 'A'
                bcc consonant  ; If less than 'A', skip
                cmp #$5B      ; Compare with 'Z'
                bcs consonant  ; If greater than 'Z', skip
                sec           ; Set carry flag for subtraction (uppercase)
                sbc #$40      ; Convert character to lowercase
vowel:
                cmp #$61      ; Compare with 'a'
                bcc consonant  ; If less than 'a', skip
                cmp #$7B      ; Compare with 'z'
                bcs consonant  ; If greater than 'z', skip
                inx           ; Increment vowel counter
                iny           ; Move to next character in string
                bra loop

consonant:
                iny           ; Move to next character in string
                bra loop

finish:
                ; Output result
                lda #$01       ; Select background color
                jsr drawBackground
                lda x
                sta PPU_ADDR
                lda #$24 ;Character $
                sta PPU_DATA
                lda #$32 ;Coords
                sta PPU_DATA
                jsr waitFrame
                lda #32
                jsr drawLetter
                lda x
                clc
                adc #$30 ;Convert to '0'
                jsr drawDigit
                                
                bra $8000     ; End of program

string:
                .db "Hello, World!", $00 ; Example string to count vowels

                .bank 1
                .org $FFFA
                .dw NMI ; Set NMI handler
                .dw RESET
    
                .bank 0 ; Uncomment this line if you want to execute code from bank 0

RESET:
                lda #$80
                sta $2000 ; Turn off PPU
    
                lda #$00
                sta PPU_CTRL ; Make sure PPU is off
                
main:
                jsr enableNMI
                
                jsr start
    
                jmp main ; Endless loop
