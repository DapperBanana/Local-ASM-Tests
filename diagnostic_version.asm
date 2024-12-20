
START LDA #0       ; Initialize accumulator
      STA HEAD     ; Initialize head pointer to 0

      LDA #20      ; Insert value 20 into linked list
      JSR INSERT

      LDA #30      ; Insert value 30 into linked list
      JSR INSERT

      LDA #10      ; Insert value 10 into linked list
      JSR INSERT

      JSR PRINT     ; Print the linked list

      JMP END       ; End the program

INSERT STA TEMP     ; Save value into temporary variable
       LDA HEAD     ; Load head pointer into accumulator
       BEQ INSERT_END ; Check if head is NULL
       LDY #0       ; Initialize index register
LOOP   LDA (HEAD),Y ; Load the next pointer from the current node
       BEQ ADD_NODE ; Check if next pointer is NULL
       INY          ; Move to next pointer
       JMP LOOP     ; Repeat loop
ADD_NODE STA (HEAD),Y ; Add a new node after the current one
        LDA TEMP     ; Load value from temporary variable
        STA (HEAD),Y ; Store value in new node
        INY          ; Move to next pointer in new node
        LDA #0       ; Set next pointer of new node to NULL
        STA (HEAD),Y
        JMP INSERT_END

INSERT_END LDA TEMP   ; Load value from temporary variable
           STA TEMP2  ; Save value into temporary variable 2
           LDA HEAD   ; Load head pointer into accumulator
           BEQ INSERT_NODE ; Check if head is NULL
           LDY #0
LOOP2      LDA (HEAD),Y ; Load the next pointer from the current node
           BEQ ADD_NODE2 ; Check if next pointer is NULL
           INY
           JMP LOOP2
ADD_NODE2  STA (HEAD),Y ; Add a new node after the current one
           LDA TEMP2
           STA (HEAD),Y
           INY
           LDA TEMP   ; Load value from temporary variable
           STA (HEAD),Y ; Store value in new node
           INY
           LDA #0
           STA (HEAD),Y ; Set next pointer of new node to NULL
           RTS
INSERT_NODE LDA TEMP  ; Load value from temporary variable
           STA (HEAD),Y ; Store value in new node
           INY
           LDA #0
           STA (HEAD),Y ; Set next pointer of new node to NULL
           RTS

PRINT LDA HEAD      ; Load head pointer into accumulator
      BEQ PRINT_END ; Check if head is NULL
      LDY #0        ; Initialize index register
PRINT_LOOP LDA (HEAD),Y ; Load value from current node
           JSR OUTPUT   ; Output value
           INY
           LDA (HEAD),Y ; Load next pointer from current node
           BEQ PRINT_END ; Check if next pointer is NULL
           JMP PRINT_LOOP
PRINT_END RTS

OUTPUT STA $FB    ; Output value to console
       JSR $FFD2  ; System call to print character
       RTS

HEAD   .BYTE 0     ; Head pointer
TEMP   .BYTE 0     ; Temporary variable
TEMP2  .BYTE 0     ; Temporary variable 2

       .ORG $4000  ; Program starts at memory address $4000
       JMP START
