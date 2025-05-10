
start:
    lda #0        ; Initialize counter to 0
    sta counter

    lda #0        ; Initialize longest common subsequence length to 0
    sta lcs_length

    lda source1   ; Load first character of source1 string
    sta ptr1
    
loop1:
    lda source1, x  ; Load next character of source1 string
    cmp #0          ; Check for null terminator
    beq done        ; If end of string, exit loop
    
    lda source2    ; Load first character of source2 string
    sta ptr2

loop2:
    lda source2, y  ; Load next character of source2 string
    cmp #0          ; Check for null terminator
    beq next_char   ; If end of string, move to next character
    
    cmp source1, x  ; Compare characters at current positions
    beq match       ; If characters match, increment counter
    
    lda lcs_length
    cmp counter     ; Compare counter to current longest common subsequence length
    bcc not_lcs     ; If greater, update longest common subsequence length
    
    lda counter
    sta lcs_length  ; Update longest common subsequence length
    
not_lcs:
    lda #0          ; Reset counter
    sta counter

    iny             ; Move to next character in source2 string
    jmp loop2

match: 
    inx             ; Move to next character in source1 string
    iny             ; Move to next character in source2 string
    inc counter     ; Increment counter
    jmp loop2

next_char:
    lda source1, x  ; Move to next character in source1 string
    bne loop1       ; If not end of string, continue loop
    
done:
    lda lcs_length  ; Load longest common subsequence length
    ; Finish program here

counter: .byte 0
lcs_length: .byte 0
ptr1: .byte 0
ptr2: .byte 0
source1: .asciiz "ABCAB"
source2: .asciiz "BAOB"
