
START    LDX #0        ; Initialize index i
         LDY #0        ; Initialize index j
         LDA $SETUP    ; Load address of the string into A
         STA $ADDR+1
         LDA #$00
         STA $ADDR
         
LOOP     LDA $ADDR,X   ; Load byte at index i
         BEQ DONE      ; If byte is 0, end of string, exit
         STA $STR,X    ; Store the byte in temporary string
         
         ; Check if a palindromic substring centered at index i, starting with odd length
         JSR CHECK_ODD
         
         ; Check if a palindromic substring centered at index i, starting with even length
         JSR CHECK_EVEN
         
         INX            ; Increment i
         BRA LOOP       ; Repeat the loop

DONE     ; Display the longest palindromic substring
         JSR DISPLAY   
         
CHECK_ODD
         LDX #$00      ; Initialize counter
ODD_LOOP LDA $STR,X   ; Load byte at index low
         STA $TEMP+1   ; Store it in temporary byte
         LDX #$01      ; Reset counter
ODD_NEXT LDA $TEMP,X  ; Load byte at index high
         CMP $STR,X   ; Compare with byte at index low
         BNE ODD_END   ; If not equal, end loop
         INX           ; Increment counter
         LDA $TEMP+1   ; Load byte at index low
         SEC
         SBC #$01      ; Decrement by 1
         STA $TEMP+1
         BPL ODD_NEXT  ; Loop again if positive
ODD_END  ; Store length of palindromic substring if longer than previous
         LDA $ADDR
         SEC
         SBC #$02
         STA $ADDR
         LDA $TEMP
         BEQ ODD_EXIT  ; Exit if length is 0
         STA $LENGTH
         LDX #$00
         STX $INDEX
         STX $TEMP
         BRA ODD_EXIT
         
CHECK_EVEN         
         LDX #$01      ; Initialize counter
EVEN_LOOP LDA $STR,X   ; Load byte at index low
         STA $TEMP+1   ; Store it in temporary byte
         LDX #$01      ; Reset counter
EVEN_NEXT LDA $TEMP,X  ; Load byte at index high
         CMP $STR,X   ; Compare with byte at index low
         BNE EVEN_END  ; If not equal, end loop
         INX           ; Increment counter
         LDA $TEMP+1   ; Load byte at index low
         SEC
         SBC #$01      ; Decrement by 1
         STA $TEMP+1
         BPL EVEN_NEXT ; Loop again if positive
EVEN_END  ; Store length of palindromic substring if longer than previous
         LDA $ADDR
         SEC
         SBC #$02
         STA $ADDR
         CMP $LENGTH
         BCS EVEN_EXIT
         LDA $TEMP
         STA $LENGTH
         LDX #$00
         STX $INDEX
         BRA EVEN_EXIT
         
DISPLAY  LDA $LENGTH   ; Load length of longest palindromic substring
         STA $LENGTH+1
         LDX #$01
         STX $INDEX
DISP_LOOP
         LDA $INDEX
         CMP $LENGTH
         BEQ DONE
         LDA $INDEX
         TAX
         LDA $STR,X
         JSR $FFD2
         INX
         LDA $INDEX
         ADC #$01
         STA $INDEX
         BRA DISP_LOOP
         
$SETUP   .BYTE $40      ; Address of the string
$ADDR    .BYTE $00      ; Current position in string
$TEMP    .BYTE $00      ; Temporary byte
$LENGTH  .BYTE $00      ; Length of longest palindromic substring
$INDEX   .BYTE $00      ; Current index
$STR     .BYTE $00, $00, $00, $00, $00, $00, $00, $00 ; Temporary string

         .END
