
        LDA #$00           ; initialize accumulator
LOOP    LDX data          ; load data
        ; perform operations on data
        ; store result back in memory
        INX                ; increment X
        CPX #end_of_data   ; compare X with end of data address
        BNE LOOP           ; loop until end of data
