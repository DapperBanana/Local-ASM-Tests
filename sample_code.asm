
        .org $0200
        SEI
        CLD
        LDX #0
loop    LDA month,X
        STA $0200,X
        INX
        CPX #12
        BNE loop
        LDX #0
print   LDA $0200,X
        JSR $FFD2
        INX
        CPX #12
        BNE print
end     BRK

month   .text "January", 0
        .text "February", 0
        .text "March", 0
        .text "April", 0
        .text "May", 0
        .text "June", 0
        .text "July", 0
        .text "August", 0
        .text "September", 0
        .text "October", 0
        .text "November", 0
        .text "December", 0
