
LDA $2000 ; Load value 'a' into accumulator
CLC       ; Clear carry bit
ADC $2003 ; Add value 'd' to accumulator
STA $2010 ; Store result in memory at address $2010

LDA $2002 ; Load value 'c' into accumulator
CLC       ; Clear carry bit
ADC $2001 ; Add value 'b' to accumulator
STA $2011 ; Store result in memory at address $2011

LDA $2010 ; Load result of ad into accumulator
SEC       ; Set carry bit
SBC $2011 ; Subtract result of bc from accumulator
STA $2012 ; Store determinant in memory at address $2012

HLT       ; Halt program
