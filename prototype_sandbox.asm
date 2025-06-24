
        .org    $0200
start   LDX     #$00        ; Initialize index variables
        LDA     #$00
        STA     largest     ; Initialize largest and second largest variables
        STA     secondLargest
        
loop    LDA     arr,X       ; Load the value at arr[X] into accumulator
        CMP     largest     ; Compare with largest so far
        BCC     update      ; If less, update largest and secondLargest
        BCS     next        ; Otherwise, move to the next element

update  STA     secondLargest
        STA     largest
        
next    INX                 ; Move to the next element
        CPX     #length     ; Compare index with length of the array
        BNE     loop        ; If not at the end, continue the loop
        
        BRK                 ; Exit the program
        
arr     .byte   $10, $20, $30, $40, $50  ; Array of values
length  .byte   5           ; Length of the array
largest .byte   $00         ; Largest element found so far
secondLargest .byte $00     ; Second largest element found so far

        .end
