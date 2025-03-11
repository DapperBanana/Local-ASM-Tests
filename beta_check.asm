
; Program to display a basic text-based calendar using 6502 assembly

        .org $0200

start   JSR init_display
        LDA #$00
        STA $00

print_loop
        LDA day_tab, X
        CMP #$FF
        BEQ end_prog
        JSR print_string
        JSR print_newline
        INX
        JMP print_loop

end_prog BRK
        
init_display
        LDX #$00
init_display_loop
        LDA $C000, X
        CMP #$00
        BEQ init_display_done
        STA $0400, X
        INX
        BNE init_display_loop

init_display_done
        RTS

print_string
        LDY #$00
print_string_loop
        LDA (X), Y
        BEQ print_string_done
        JSR print_char
        INY
        JMP print_string_loop

print_string_done
        RTS

print_char
        STA $D020
        RTS

print_newline
        LDA #$0D
        JSR print_char
        LDA #$0A
        RTS

day_tab .byte "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", $FF

        .end
