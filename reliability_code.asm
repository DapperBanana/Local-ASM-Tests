
; File Compression Algorithm
; This program reads a file of bytes and compresses it using a simple RLE algorithm

; Constants
BLOCK_SIZE = 128 ; Number of bytes to read at a time
COMPRESSED_FILE_START = $4000 ; Start address of compressed file
UNCOMPRESSED_FILE_START = $2000 ; Start address of uncompressed file

; Variables
buffer = $00 ; Buffer to store block of bytes
currentByte = $01 ; Current byte being processed
count = $02 ; Count of consecutive bytes
compressedByte = $03 ; Compressed byte to write to file
currentIndex = $04 ; Current index in buffer
compressedIndex = $05 ; Current index in compressed file

ORG $2000

main:
    LDX #0 ; Initialize index
    LDA UNCOMPRESSED_FILE_START, X ; Load first byte
    STA currentByte ; Store current byte
    INX ; Increment index
    
loop:
    LDA UNCOMPRESSED_FILE_START, X ; Load next byte
    CMP currentByte ; Compare with previous byte
    BEQ incrementCount ; If equal, increment count
    BEQ flushBuffer ; Flush buffer if different
    JMP nextByte ; Process next byte

incrementCount:
    INC count ; Increment count
    INX ; Increment index
    CMP #BLOCK_SIZE ; Check if block size reached
    BNE loop ; If not, continue processing
    
flushBuffer:
    LDY #0 ; Initialize index
    LDA count ; Load count
    STA buffer, Y ; Store count in buffer
    INY ; Increment index
    LDA currentByte ; Load current byte
    STA buffer, Y ; Store current byte in buffer

    LDX #0 ; Reset index
    LDA buffer, X ; Load compressed byte
    STA compressedByte ; Store compressed byte
    INX ; Increment index
    
    LDX #0 ; Reset index
    LDA buffer, X ; Load count
    STA COMPRESSED_FILE_START, X ; Store count in compressed file
    INX ; Increment index
    LDA compressedByte ; Load compressed byte
    STA COMPRESSED_FILE_START, X ; Store compressed byte in compressed file
    
    LDA #0 ; Reset count
    STA count
    JMP nextByte ; Process next byte

nextByte:
    LDY #0 ; Reset index
    LDA UNCOMPRESSED_FILE_START, X ; Load next byte
    STA currentByte ; Store next byte
    INX ; Increment index
    CPX #BLOCK_SIZE ; Check if end of file
    BNE loop ; If not, continue looping
    
    RTS ; Return from subroutine
