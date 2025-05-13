
RESET     ORG $FFFC     ; Reset vector
          DB $00
          DB $C0

LIST_PTR  .DSW 1        ; Pointer to the start of the linked list
CUR_PTR   .DSW 1        ; Pointer to the current node in the linked list

; Subroutine to add a new node to the linked list
ADD_NODE  LDX #0        ; Initialize index register
          LDA #10       ; Allocate memory for new node
          STA $0200,X   ; Store data in new node
          DEX           ; Decrement index register
          BPL $FB       ; Branch back if not done
          LDA CUR_PTR   ; Load current pointer
          STA $0200     ; Store pointer in current node
          STA CUR_PTR   ; Update current pointer
          RTS           ; Return from subroutine

; Subroutine to print the entire linked list
PRINT_LIST
          LDA #0        ; Load accumulator with 0
LOOP      LDX #0        ; Load index register with 0
          LDA LIST_PTR  ; Load start of linked list
          CLC           ; Clear carry flag
          ADC X         ; Add index to start of list
          STA CUR_PTR   ; Update current pointer
          LDA CUR_PTR   ; Load current pointer
          BNE $FD       ; Branch to end of list if pointer is 0
          LDA $0200,X   ; Load data from current node
          JSR $FFFE     ; Call subroutine to print data
          LDA CUR_PTR   ; Load current pointer
          STA CUR_PTR   ; Update current pointer
          BNE LOOP      ; Repeat loop if pointer is not 0
          RTS           ; Return from subroutine

          .END          ; End of program
