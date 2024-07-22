
        .org $0200
start:  LDX #$00
        LDA input,X
        CMP #"{"
        BNE not_json
        INX
check_loop:
        LDA input,X
        BEQ done
        CMP #"}"
        BEQ valid_json
        INX
        JMP check_loop
not_json:
        LDA #$00
        STA output
        JMP end
valid_json:
        LDA #$01
        STA output
end:    BRK

input:  .asciiz "{'key': 'value'}"
output: .byte $00

        .org $FFFC
        .word start
