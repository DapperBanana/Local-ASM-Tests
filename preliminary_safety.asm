
 ; Fibonacci sequence generator
 ORG $0600
start:
  LDX #0 ; Initialize index
  LDY #1 ; Initialize second term
  STX result1 ; Store index as first term
  
loop:
  LDA result1 ; Load first term
  CLC
  ADC result2 ; Add second term
  STA result1 ; Store sum as new first term
  
  LDA result2 ; Load second term
  STA result2 ; Store second term in temp
  
  TXA ; Increment index
  CLC
  ADC #1
  TAX ; Store new index
  
  LDY result1 ; Load new first term
  CPY max_terms ; Check number of terms
  BCC loop ; Continue loop if not reached max terms
  
done:
  BRK ; End program
  
result1: .BYTE 0 ; Declare variable for first term
result2: .BYTE 1 ; Declare variable for second term
max_terms: .BYTE 10 ; Number of terms to generate
