
    .org $0000

start:
    ldx #$00         ; Initialize index register X to zero
    ldy #$00         ; Initialize index register Y to zero
    lda inventory,x  ; Load the quantity at the current index
    cmp #$00         ; Compare the quantity to zero
    beq out_of_stock ; Branch if the quantity is zero
    jsr display_item ; Display the item
    jsr display_quantity ; Display the quantity
    inx              ; Increment index register X
    bne start        ; Branch to start if not equal to zero
    rts              ; Return to caller

display_item:
    lda items,y      ; Load the item name at the current index
    ; Display the item name (e.g., print it to the screen)
    rts              ; Return to caller

display_quantity:
    lda inventory,x  ; Load the quantity at the current index
    ; Display the quantity (e.g., print it to the screen)
    rts              ; Return to caller

out_of_stock:
    ; Display an out of stock message
    rts              ; Return to caller

    .org $0100

items:
    .byte "Item1",0
    .byte "Item2",0
    .byte "Item3",0

inventory:
    .byte $10,$20,$00  ; Initial quantities of each item

    .end
