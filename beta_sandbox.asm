
        .org $2000

XMLString .byte "<!DOCTYPE XML ["

DTDString .byte "<!ELEMENT name (#PCDATA)>"
           .byte "]>"

CheckXML:

        LDX #$00        ; Initialize index pointer
        LDA XMLString, X    ; Load first character of XML string
        CMP DTDString, X+   ; Compare with first character of DTD string
        BNE NotValid     ; If not equal, XML is not valid

CheckNextChar:

        INX             ; Increment index pointer
        LDA XMLString, X    ; Load next character of XML string
        CMP DTDString, X    ; Compare with next character of DTD string
        BNE NotValid     ; If not equal, XML is not valid
        CMP #0           ; Check for end of string
        BNE CheckNextChar
        RTS             ; Return if both strings match

NotValid:

        LDA #$00        ; Set result to false
        RTS             ; Return with false result

        .end
