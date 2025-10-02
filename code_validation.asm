
START LDX #0         ; Initialize index X to 0
     LDY #0         ; Initialize index Y to 0
     CLC           ; Clear carry flag

LOOP LDA STR1,X     ; Load character from first string into A
     CMP #0         ; Check if end of string 1
     BEQ END        ; If end of string 1, go to END
     TAX           ; Store A into X

INNER LDA STR2,Y    ; Load character from second string into A
      CMP #0        ; Check if end of string 2
      BEQ CHECK     ; If end of string 2, go to CHECK
      CPX           ; Compare A with character from string 1
      BNE NEXT      ; If not equal, go to NEXT
      INX           ; Increment index X
      INY           ; Increment index Y
      JMP INNER     ; Continue inner loop

CHECK LDA STR1,X    ; Load character from first string into A
      CMP #0        ; Check if end of string 1
      BEQ END       ; If end of string 1, go to END
      INY           ; Increment index Y
      LDA STR1,X     ; Load character from first string into A
      JMP LOOP      ; Continue outer loop

NEXT INY             ; Increment index Y
     LDX #0          ; Reset index X to 0
     JMP LOOP       ; Continue outer loop

END  RTS            ; End of program

STR1 .BYTE "ABCD",0  ; First string
STR2 .BYTE "BD",0    ; Second string
