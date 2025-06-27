
; 6502 Assembly language translator program
; Translates English words to Spanish words

.word		$0300
.src		"hello"
.dst		"hola"
	 
.word		$0306
.src		"goodbye"
.dst		"adios"
	
.word		$030d
.src		"yes"
.dst		"si"
	
.word		$0311
.src		"no"
.dst		"no"
	
.word		$0314
.src		"apple"
.dst		"manzana"
	 
.word		$031a
.src		"banana"
.dst		"platano"
	
.word		$0321
.src		"cat"
.dst		"gato"
	
.word		$0326
.src		"dog"
.dst		"perro"
	
.word		$032b
.src		"red"
.dst		"rojo"
	
.word		$0330
.src		"blue"
.dst		"azul"
	
start
	LDX #0		; Initialize index
loop
	LDA .src,X	; Load source character
	BEQ end	; If end of string, exit loop
	STA $0400,X	; Store source character
	ADC #$01	; Increment index
	INX		; Increment index
	JMP loop	; Go to next character
end
	LDA .dst,X	; Load destination character
	STA $0400,X	; Store destination character
	INX		; Increment index
	LDA .dst,X	; Load null terminator
	STA $0400,X	; Store null terminator
	
	; Print translated string
	LDX #0		; Reset index
loopprint
	LDA $0400,X	; Load character
	BEQ endprint	; If null terminator, exit loop
	JSR $ffd2	; Print character to screen
	INX		; Increment index
	JMP loopprint	; Continue loop
endprint
	RTS		; Return
