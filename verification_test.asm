
; Program to extract hashtags from a given text
; Input:
; - Text string at memory address $4000 onwards
; Output:
; - List of hashtags separated by spaces stored at memory address $4100 onwards

START     LDX #0
          LDA $4000,X    ; Load next character from text
          BEQ DONE       ; Exit if end of text
          CMP '#'
          BEQ FOUND_HASHTAG
          INX
          JMP START

FOUND_HASHTAG
          STX $4100      ; Store hashtag start index
          INX
SCAN_HASHTAG
          LDA $4000,X
          CMP ' '         ; Check for space or end of text
          BEQ END_HASHTAG
          STA $4101,X     ; Store hashtag character
          INX
          JMP SCAN_HASHTAG

END_HASHTAG
          LDA '#'
          STA $4101,X     ; Store null terminator
          INX
          JMP START

DONE      BRK            ; End program

          .ORG $4000
text      .ASC "This is a #sample text with multiple #hashtags #extracted."
          .BYTE 0

          .ORG $4100
hashtags  .BYTE 0

          .ORG $FFFC
          .WORD START
