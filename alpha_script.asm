
        ; Decimal to Binary Converter
        ; Input: Decimal number
        ; Output: Binary representation of the input number

        .org $0200  ; start program at memory location $0200

START   LDA #$00    ; load accumulator with 0
        STA $00      ; store accumulator in memory location $00
        LDA #$00    ; load accumulator with 0
        STA $01      ; store accumulator in memory location $01

INPUT   LDX $00      ; load X register with memory location $00
        JSR GETDEC   ; jump to subroutine to get decimal input
        STA $02      ; store input in memory location $02

CONVERT LDA $02      ; load accumulator with input number
        AND #$01     ; bitwise AND with 0000 0001 to check if LSB is 1
        BNE ONE      ; if result is not 0 jump to ONE
        LDA #$30    ; load accumulator with ASCII character '0'
        STA $03,X    ; store '0' in memory location $03 + X
        INX         ; increment X register
        LSR         ; logical shift right by 1
        LDA $02      ; load accumulator with input number
        STA $02      ; store accumulator back in memory location $02
        JMP CHECK    ; jump to CHECK

ONE     LDA #$31    ; load accumulator with ASCII character '1'
        STA $03,X    ; store '1' in memory location $03 + X
        INX         ; increment X register
        LSR         ; logical shift right by 1
        LDA $02      ; load accumulator with input number
        STA $02      ; store accumulator back in memory location $02

CHECK   CMP #$00    ; compare accumulator with 0
        BNE CONVERT  ; if not equal, repeat CONVERT
        LDX $00      ; load X register with memory location $00
PRINT   LDA $03,X    ; load accumulator with converted binary number
        JSR PUTCHR   ; jump to subroutine to print character
        DEX         ; decrement X register
        CPX #$FF    ; compare X register with -1
        BNE PRINT    ; if not equal, repeat PRINT

END     BRK         ; end program

GETDEC  LDA #$00    ; load accumulator with 0
        STA $00      ; store accumulator in memory location $00
        LDA #$00    ; load accumulator with 0
        STA $01      ; store accumulator in memory location $01

GETCHAR LDA #$01    ; load accumulator with 1 to read character
        JSR $FFCF    ; jump to KERNAL routine to read character
        CMP #$0D    ; compare accumulator with ENTER key
        BEQ RETURN  ; if equal, return
        STA $01      ; store accumulator in memory location $01
        LDX $01      ; load X register with memory location $01
        LDA $02,X    ; load accumulator with input number
        CMP #$2F    ; compare accumulator with '/'
        BEQ SKIP    ; if equal, skip ASCII characters '/'
        CMP #$39    ; compare accumulator with '9'
        BGT ERROR   ; if greater than '9' display error
        CMP #$30    ; compare accumulator with '0'
        BLT ERROR   ; if less than '0' display error
        CLC         ; clear carry flag
        ASL         ; arithmetic shift left by 1
        ROL $00      ; rotate left 1 bit and store in memory location $00
        BCC CONTINUE ; if no carry set, continue
        ORA #$01    ; logical OR with 0000 0001
        ROL $00      ; rotate left 1 bit and store in memory location $00
        CLC         ; clear carry flag
        BCC CONTINUE ; if no carry set, continue
CONTINUE INX         ; increment X register
        JMP GETCHAR  ; jump back to GETCHAR

SKIP    INX         ; increment X register
        JMP GETCHAR  ; jump back to GETCHAR

ERROR   LDA #$FF    ; load accumulator with error character
        JSR PUTCHR   ; jump to subroutine to print character
        JMP GETCHAR  ; jump back to GETCHAR

RETURN  RTS         ; return from subroutine

PUTCHR  JSR $FFD2    ; jump to KERNAL routine to print character
        RTS         ; return from subroutine

        .org $FFCF  ; define KERNAL routine for reading character
        .byte $20   ; $FFCF Read a character

        .end        ; end of program
