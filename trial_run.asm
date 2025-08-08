
START    LDA #0         ; Initialize accumulator
         STA $FB        ; Initialize head of linked list to 0

; Add a new node to the linked list
ADD_NODE LDX $FB        ; Load head of linked list into X register
         BEQ HEAD_IS_0 ; If head of list is 0, create new node
NEXT_NODE LDA (X),Y     ; Load next node address
         BEQ ADD_NEW_NODE ; If next node address is 0, add new node after current node
         TAY           ; Copy Y register to Y register
         INX           ; Increment X register to next node
         BNE NEXT_NODE ; Loop to check next node

ADD_NEW_NODE
         LDX $FB       ; Load head of linked list into X register
         BEQ NEW_NODE ; If head of list is 0, create new node
NEXT_NEW LDA (X),Y     ; Load next node address
         TAY           ; Copy Y register to Y register
         INX           ; Increment X register to next node
         BNE NEXT_NEW  ; Loop to check next node

NEW_NODE STA $FC       ; Store new node address in location $FC
         LDA #$00
         STA (X),Y     ; Set next node address for current node
         STY (X)       ; Store data at new node address
         RTS

; Remove a node from the linked list
REMOVE_NODE
         LDX $FB       ; Load head of linked list into X register
         BEQ EMPTY_LIST ; If head of list is 0, list is empty
NEXT_REM LDA (X),Y     ; Load next node address
         BEQ END_REMOVE ; If next node address is 0, end remove operation
         TAY           ; Copy Y register to Y register
         INX           ; Increment X register to next node
         BEQ EMPTY_LIST ; If head of list is 0, list is empty
         BNE NEXT_REM  ; Loop to check next node

END_REMOVE
         LDA #$00
         STA (X), Y    ; Set next node address for current node to 0
         RTS

EMPTY_LIST
         RTS

; Print out the linked list
PRINT_LIST
         LDX $FB       ; Load head of linked list into X register
         BEQ END_PRINT ; If head of list is 0, list is empty
NEXT_PRN LDA (X),Y     ; Load next node address
         BEQ END_PRINT ; If next node address is 0, end print operation
         TAY           ; Copy Y register to Y register
         INX           ; Increment X register to next node
         BNE NEXT_PRN  ; Loop to check next node

END_PRINT
         RTS

         .ORG $1000    ; Start of program in memory
         JMP START     ; Jump to start of program
