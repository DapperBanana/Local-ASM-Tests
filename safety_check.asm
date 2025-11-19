
; Program to find the median of a list of numbers
; List of numbers is stored starting at address $2000
; The length of the list is stored at address $2001

        .org $0200

start   ldx     #$00            ; Initialize index register to 0
        lda     $2001           ; Load the length of the list
        asl                     ; Multiply by 2 to get the number of bytes
        tax                     ; Store the result in X register

        lda     $2000,x         ; Load a number from the list
        sta     $02             ; Store it in memory location $02
        dex                     ; Decrement index
        lda     $2000,x         ; Load another number from the list
        sta     $03             ; Store it in memory location $03

loop    sta     $04             ; Store the number in memory location $04
        lda     $2000,x         ; Load another number from the list
        sec                     ; Set carry flag
        sbc     $04             ; Subtract the number in $04 from the new number
        bcs     skip            ; If new number is greater, skip swapping
        lda     $04             ; Load the number in memory location $04
        sta     $2000,x         ; Store it in the list
        sta     $2002,x         ; Store it in the list for comparison
        dex                     ; Decrement index
        bne     loop            ; Continue looping until index is 0

        lda     $2002           ; Load the median number from the list
        sta     $01             ; Store it in memory location $01

done    ; Program ends here

skip    lda     $04             ; Load the number in memory location $04
        sta     $2000,x         ; Store it in the list for comparison
        sta     $2002,x         ; Store it in the list for comparison
        dex                     ; Decrement index
        bne     loop            ; Continue looping until index is 0

        bne     done            ; Go to done if index is 0
