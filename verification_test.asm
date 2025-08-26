
ORG $0200  ; Start of program

START LDA $0300  ; Load the length of the string
     BEQ END     ; If the length is 0, jump to the end of the program
     STA $00     ; Store the length in memory
     LDX #$01    ; Set X to 1 to skip the first character (assume it is already in title case)

LOOP LDA $0300,X  ; Load a character from the string
     CMP #$61    ; Compare character to lowercase 'a'
     BCC NOT_LOWER ; If character is not lowercase, skip conversion
     CMP #$7A    ; Compare character to lowercase 'z'
     BCS NOT_LOWER ; If character is not lowercase, skip conversion
     SEC
     SBC #$20    ; Convert lowercase to uppercase
     STA $0300,X ; Store the converted character back in the string

NOT_LOWER INX        ; Increment X to move to the next character
          CPX $00   ; Compare X to the length of the string
          BCC LOOP  ; If X is less than the length, continue looping

END  BRK  ; End of program

   .ORG $0300
   .BYTE 12  ; Length of the string
   .ASCII "hello world"  ; String to convert to title case

   .END
