
        .org $0200         ; program start address

start   lda #8            ; set password length
        sta passwordLength
        ldx #0            ; initialize index
        ldy randSeed      ; load random seed address

generatePassword:
        lda randSeed      ; load random seed
        clc
        adc #17           ; add 17 to seed for randomness
        sta randSeed
        and #$7F          ; mask MSB to get printable ASCII characters
        sta $0200,x       ; store character in password buffer
        inx               ; increment index
        cpx passwordLength ; check if password is complete
        bne generatePassword ; if not complete, loop

done    brk               ; end program

passwordLength: .byte 0
randSeed: .byte $FF

        .org $FFFC         ; set reset vector address
        .word start        ; start of program
