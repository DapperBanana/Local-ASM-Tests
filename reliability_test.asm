
  LDX #0    ; Initialize index to lookup table
  LDY input_num  ; Load input number
  LDZ #0    ; Initialize result string pointer
  LDA #0    ; Clear accumulator

loop:
  LDA decimal_values, X  ; Load decimal value from lookup table
  CMP #0    ; Check for end of table (null terminator)
  BEQ done

  CMP Y     ; Compare decimal value to input number
  BCC skip  ; Branch if decimal value is too large

  SBC Y     ; Subtract decimal value from input number
  STA Y     ; Store updated input number

  LDA roman_numerals, X  ; Load corresponding Roman numeral
  STA result_string, Z   ; Store Roman numeral in result string
  INX       ; Move to next index in lookup table
  INZ       ; Move to next position in result string

  BRA loop  ; Repeat loop

skip:
  INX       ; Move to next index in lookup table
  BRA loop  ; Repeat loop

done:
  LDA result_string  ; Load result string pointer
  JSR print_string  ; Print or store result string
