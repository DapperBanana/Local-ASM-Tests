
        .org $0200     ; Start address of program

start   ldx #$00       ; Initialize index X to 0
        ldy #$00       ; Initialize index Y to 0

outer   lda list,y    ; Load value at index Y into A
        cmp list+1,y  ; Compare value with next value in list
        bcc skip_swap ; Branch if A < (list+1). If not, skip the swap
        
        sta temp      ; Store current value in temporary variable
        lda list+1,y  ; Load next value into A
        sta list,y    ; Store next value in current position
        lda temp      ; Load temporary value into A
        sta list+1,y  ; Store current value in next position

skip_swap
        iny            ; Increment index Y
        cpy #7         ; Check if end of list is reached
        bne outer      ; If not, repeat outer loop

        dex            ; Decrement index X
        cpx #7         ; Check if end of list is reached
        bne outer      ; If not, repeat outer loop

        rts            ; Return from subroutine

list    .byte $05,$02,$07,$01,$08,$04,$03,$06    ; List of integers to be sorted
temp    .byte $00      ; Temporary storage for swapping values
