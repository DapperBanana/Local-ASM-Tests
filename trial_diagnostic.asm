
    .org $0200
    
start
    lda #0      ; initialize first Fibonacci number
    sta current
    lda #1      ; initialize second Fibonacci number
    sta next
    
    lda #10     ; number of terms to generate
    sta count
    
loop
    lda current
    clc
    adc next
    sta temp
    
    lda next
    sta current
    
    lda temp
    sta next
    
    lda current
    jsr printNumber
    
    lda count
    dec
    bne loop
    
    rts
    
printNumber
    ; convert number to ASCII and print
    clc
    lda #48
    adc current
    sta $02        ; store tens place
    
    lda #48
    adc #0
    sta $03        ; store ones place
    
    lda $03
    jsr $ffcf      ; SYS 57295 for PETSCII conversion
    lda $02
    jsr $ffcf
    
    lda #$20       ; space character
    jsr $ffd2      ; KERNAL routine for output
    
    rts
