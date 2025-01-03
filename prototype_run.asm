
ORG $1000

start:
  LDX #0               ; Set X register to 0
  LDY #seed            ; Load seed value
  JSR randomize        ; Call randomize function to initialize random number generator
  
generate_sentence:
  LDY #table           ; Load address of transition table
  LDA (Y,X)            ; Load first character from table
  
append_character:
  STA $00              ; Store character in memory
  JSR print_character  ; Call print_character function to output character
  
  CMP #$00             ; Check for end of sentence marker
  BEQ end             ; If end of sentence marker found, end program
  
  JSR get_next_char    ; Call get_next_char function to get next character based on current character
  JMP append_character ; Jump back to append_character to append next character to sentence
  
end:
  BRK                  ; Break program

randomize: ; Randomize function to initialize random number generator
  TXA                  ; Transfer X register to accumulator
  TYA                  ; Transfer Y register to accumulator
  SEC                  ; Set carry flag
  SBC #$69             ; Subtract 105 from accumulator
  STX rand_seed        ; Store result in rand_seed
  RTS

print_character: ; Print character function
  LDA $00              ; Load character from memory
  JSR $FFD2            ; Call system routine to print character
  RTS

get_next_char: ; Get next character function
  LDA (Y,X)            ; Load next character based on transition table
  INX                  ; Increment X register
  RTS

seed: .byte $42         ; Seed value for random number generator

table:                  ; Transition table for Markov chains
  .byte 'T','h','e',    ; The
        ' ',
        'c','a','t',    ; cat
        ' ',
        'i','s',        ; is
        ' ',
        'o','n',        ; on
        ' ',
        't','h','e',    ; the
        ' ',
        'm','a','t',    ; mat
        '.',
        $00             ; End of sentence marker
