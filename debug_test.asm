
    .org $0200

start:
    lda #0
    sta $fd
    lda #<stocks
    sta $fb
    lda #>stocks
    sta $fc

mainLoop:
    jsr printMenu
    jsr getInput
    cmp #$30
    beq buyStock
    cmp #$31
    beq sellStock
    cmp #$32
    beq checkBalance
    cmp #$33
    beq exitProgram
    jmp mainLoop

buyStock:
    jsr printBuyMenu
    jsr getInput
    cmp #$30
    beq buyAAPL
    cmp #$31
    beq buyAMZN
    cmp #$32
    beq buyGOOG
    cmp #$33
    beq buyMSFT
    jmp mainLoop

buyAAPL:
    lda $fb
    clc
    adc #10
    sta $fb
    jsr printSuccess
    jmp mainLoop

buyAMZN:
    lda $fc
    clc
    adc #20
    sta $fc
    jsr printSuccess
    jmp mainLoop

buyGOOG:
    lda $fd
    clc
    adc #30
    sta $fd
    jsr printSuccess
    jmp mainLoop

buyMSFT:
    lda $fe
    clc
    adc #25
    sta $fe
    jsr printSuccess
    jmp mainLoop

sellStock:
    jsr printSellMenu
    jsr getInput
    cmp #$30
    beq sellAAPL
    cmp #$31
    beq sellAMZN
    cmp #$32
    beq sellGOOG
    cmp #$33
    beq sellMSFT
    jmp mainLoop

sellAAPL:
    lda $fb
    sec
    sbc #10
    sta $fb
    jsr printSuccess
    jmp mainLoop

sellAMZN:
    lda $fc
    sec
    sbc #20
    sta $fc
    jsr printSuccess
    jmp mainLoop

sellGOOG:
    lda $fd
    sec
    sbc #30
    sta $fd
    jsr printSuccess
    jmp mainLoop

sellMSFT:
    lda $fe
    sec
    sbc #25
    sta $fe
    jsr printSuccess
    jmp mainLoop

checkBalance:
    jsr printBalance
    jmp mainLoop

exitProgram:
    rts

printMenu:
    lda #'1'
    jsr $ffd2
    lda #' Buy Stock (0-3)'
    jsr $ffd2
    lda #' Sell Stock (0-3)'
    jsr $ffd2
    lda #' Check Balance'
    jsr $ffd2
    lda #' Exit Program'
    jsr $ffd2
    rts

printBuyMenu:
    lda #' Buying Stock!'
    jsr $ffd2
    lda #' Buy AAPL (Price: $10)'
    jsr $ffd2
    lda #' Buy AMZN (Price: $20)'
    jsr $ffd2
    lda #' Buy GOOG (Price: $30)'
    jsr $ffd2
    lda #' Buy MSFT (Price: $25)'
    jsr $ffd2
    rts

printSellMenu:
    lda #' Selling Stock!'
    jsr $ffd2
    lda #' Sell AAPL (Price: $10)'
    jsr $ffd2
    lda #' Sell AMZN (Price: $20)'
    jsr $ffd2
    lda #' Sell GOOG (Price: $30)'
    jsr $ffd2
    lda #' Sell MSFT (Price: $25)'
    jsr $ffd2
    rts

printBalance:
    lda #'AAPL: $'
    jsr $ffd2
    lda $fb
    jsr $ffd2
    lda #' AMZN: $'
    jsr $ffd2
    lda $fc
    jsr $ffd2
    lda #' GOOG: $'
    jsr $ffd2
    lda $fd
    jsr $ffd2
    lda #' MSFT: $'
    jsr $ffd2
    lda $fe
    jsr $ffd2
    rts

printSuccess:
    lda #'Transaction Successful!'
    jsr $ffd2
    rts

getInput:
    lda #'Select option: '
    jsr $ffd2
    lda #' '
    jsr $ffd2
    ldx #0
inputLoop:
    jsr $ffd2
    lda #$ff
    jsr $ffd2
    jsr $ffb7
    inx
    bne inputLoop
    rts

stocks:
    .byte $0a, $14, $1e, $19

    .end
