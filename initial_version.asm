
ORG $8000

    LDA #$00        ; Initialize variables
    STA ptr
    LDA #$01
    STA freq
    
readNextByte:
    LDA $4000,X     ; Read next byte from input text
    BEQ endOfFile   ; If end of file, go to endOfFile
    
    CLC
    ADC freq,$8000  ; Increment frequency count for this byte
    STA freq,$8000
    
    INX             ; Move to next byte
    JMP readNextByte

endOfFile:
    LDA #$7F        ; Initialize pointer to last valid byte
    STA ptr
    
encodeText:
    LDA ptr
    BMI endEncoding    ; If all bytes encoded, go to endEncoding
    
    LDA freq,$8000     ; Find byte with lowest frequency
    STA minFreq
    LDA #$00
    STA minByte
    
    LDX #$00
findMinFreq:
    LDA freq,X,$8000
    CMP minFreq
    BCS notMinFreq
    STA minFreq
    LDA X
    STA minByte
    
notMinFreq:
    INX
    CPX #$7F
    BNE findMinFreq
    
    LDA minByte
    STA encodedText,Y  ; Store encoded byte
    STX freq,minByte,$8000  ; Mark byte as encoded
    INY
    
    LDA ptr
    DEC ptr
    JMP encodeText

endEncoding:
    BRK

ptr: .BYTE 0
freq: .BYTE 0
minFreq: .BYTE 0
minByte: .BYTE 0
encodedText: .BLOCK 128

    .END
