
        .org $0200
        
matrix  .byte $01, $02, $03, $04  ; example 2x2 matrix
        
        lda matrix       ; load A with matrix[0][0]
        clc
        adc $0001         ; add matrix[0][1]
        
        sta $00           ; store result in $00
        
        lda matrix+1     ; load A with matrix[0][1]
        clc
        adc $0002         ; add matrix[1][1]
        
        sec
        sbc matrix+2      ; subtract matrix[1][0]
        
        sta $01           ; store result in $01
        
        lda $00           ; load A with det
        sec
        sbc $01           ; subtract det
        sta $02           ; store result in $02
        
        rts
