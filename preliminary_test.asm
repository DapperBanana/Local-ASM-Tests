
START LDA #0         ; Initialize index to 0
     STA INDEX
    
LOOP LDA LIST1,X    ; Load value from first list
     CMP LIST2,X    ; Compare with value from second list
     BEQ FOUND      ; If equal, go to FOUND
    
     INC X          ; Increment index
     CMP X, #SIZE   ; Compare with list size
     BNE LOOP       ; If not end of list, go back to LOOP
     
     RTS            ; Return if end of list
     
FOUND STA COMMON,Y  ; Store common element
     INC Y          ; Increment index for common element
     INC X          ; Increment index for first list
     JMP LOOP       ; Continue searching for common elements

COMMON .BLKW SIZE   ; Reserve memory for common elements

INDEX .BYTE 0
X     .BYTE 0
Y     .BYTE 0

SIZE = 5            ; Size of the lists

LIST1 .BYTE 1, 2, 3, 4, 5  ; First list
LIST2 .BYTE 2, 4, 6, 8, 10 ; Second list
