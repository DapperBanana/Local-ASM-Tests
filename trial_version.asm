
        .text
        .org $0200

prompt: .asciiz ">> "
like:   .byte 0

        .org $0200
        
start:
        ldx #0              ; Initialize post count
        lda #0              ; Initialize like count
        
mainLoop:
        jsr printPrompt     ; Print prompt (">> ")
        jsr getUserInput    ; Get user input
        cmp #"p"            ; Check if user wants to post
        beq post
        cmp #"l"            ; Check if user wants to like
        beq like
        cmp #"f"            ; Check if user wants to view feed
        beq feed
        cmp #"q"            ; Check if user wants to quit
        beq quit

        jmp mainLoop
        
post:
        lda msgBuffer,x     ; Load user input to A register
        sta postBuffer,x    ; Store post in buffer
        inx
        cpx #256            ; Check if post is complete
        bne mainLoop
        
        lda #0              ; Reset post count
        sta $fb
        lda #0              ; Reset like count
        sta like
        
        jmp mainLoop

like:
        lda like            ; Increment like count
        clc
        adc #1
        sta like
        
        jmp mainLoop

feed:
        lda #$fd            ; Start of post buffer
        ldx #0              ; Post count
        
printLoop:
        lda postBuffer,x    ; Load post to A register
        beq mainLoop        ; Exit loop if end of post
        jsr printChar       ; Print character
        inx
        lda postBuffer,x
        bne printLoop

        jmp mainLoop

quit:
        rts

printPrompt:
        ldx #0
        
printPromptLoop:
        lda prompt,x        ; Load character to A register
        beq endPrintPrompt
        jsr printChar       ; Print character
        inx
        jmp printPromptLoop

endPrintPrompt:
        rts
        
printChar:
        jsr $ffd2           ; KERNAL routine to print character
        rts
        
getUserInput:
        lda #$ff            ; Maximum input size
        ldx msgBuffer       ; Location to store input
        jsr $ffcc           ; KERNAL routine to get input
        rts

        .bss
msgBuffer: .blk 256         ; Buffer for user input
postBuffer: .blk 256        ; Buffer for posts
