
; Random Walk Generator Program

    processor 6502
    include "vcs.h"
    include "macro.h"

    org $0200

;;; Macro for generating random numbers between -1 and 1
ControlRandom	    MACRO		
		LDX	#1
		PROC	Random
		BMI	Argh
		PAUSE		      ; generate random number	
		RETURN
Argh	DEC	XSP
		LDY XSP
		STY RANDOM_VALUE+1
		RETURN
	ENDM

;;; Data for storing the random values
RANDOM_VALUE = $F0

;;; Main program
Start:  
	CLD			; Clear the decimal mode
	LDA	#$01		; Initialize random seed
	STA	RANDOM_SEED
	 
	LDX	#31		; Initialize array index
RandomWalk:  
	ControlRandom		; Generate random value between -1 and 1
	LDA RANDOM_VALUE	; Load the generated random value
	STA RANDOM_ARRAY,X	; Store value in array
	LDA RANDOM_ARRAY,X
	AND #$80
	BNE Negative		; If negative, branch to Negative
	PLA
	STA TEMP
	BEQ Positive		; Otherwise, branch to Positive
Negative:
	PLA
	SEC
	SBC #$80
	STA TEMP
Positive:
	LDA TEMP		; Add current value to previous value
	CLC
	ADC ACTUAL_POS,X
	STA ACTUAL_POS,X
	NOP			; Waste a cycle to make it branch friendly
	DEX			; Decrement index
	BPL RandomWalk		; Loop until all values are generated 
	
Complete:   
	HALT			; Stop

;;; Data section
    org $F0
RANDOM_ARRAY:   .byte   31
ACTUAL_POS:	    .byte	31
TEMP:	        .byte	$00
RANDOM_SEED:	.byte   $00

    end Start
