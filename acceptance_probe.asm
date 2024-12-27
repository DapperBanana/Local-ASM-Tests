
        .org    $0200

start   lda     #<url            ; load low byte of url address
        sta     $fb             ; store in zero page address $fb
        lda     #>url            ; load high byte of url address
        sta     $fc             ; store in zero page address $fc

check_url:
        lda     $fb             ; load low byte of url address
        sta     $fc             ; store in zero page address $fc
        lda     $fc             ; load high byte of url address
        sta     $fd             ; store in zero page address $fd

        lda     $fb             ; load low byte of url address
        clc
        adc     $fb             ; add 1 to address
        sta     $fb             ; store in low byte
        lda     $fc             ; load high byte of address
        adc     $fc             ; add carry to high byte
        sta     $fc             ; store in high byte

        lda     ($fb),y         ; load character from address
        beq     end_url         ; if end of string, exit program
        cmp     #'h'            ; check for 'h' in "http://"
        bne     invalid_url     ; if not found, url is invalid

        lda     ($fb),y         ; load next character
        cmp     #'t'            ; check for 't'
        bne     invalid_url     ; if not found, url is invalid

        lda     ($fb),y         ; load next character
        cmp     #'t'            ; check for 't'
        bne     invalid_url     ; if not found, url is invalid

        lda     ($fb),y         ; load next character
        cmp     #'p'            ; check for 'p'
        bne     invalid_url     ; if not found, url is invalid

        lda     ($fb),y         ; load next character
        cmp     #':'            ; check for ':'
        bne     invalid_url     ; if not found, url is invalid

        lda     ($fb),y         ; load next character
        cmp     #'/'            ; check for '/'
        bne     invalid_url     ; if not found, url is invalid

        lda     ($fb),y         ; load next character
        cmp     #'/'            ; check for '/'
        bne     invalid_url     ; if not found, url is invalid

        lda     ($fb),y         ; load next character
        bne     check_url       ; repeat until end of string

valid_url:
        lda     #$01            ; valid url
        jmp     end_prog

invalid_url:
        lda     #$00            ; invalid url
        jmp     end_prog

end_url:
        lda     #$01            ; valid url
        jmp     end_prog

end_prog:
        rts

url     .asc    "https://www.example.com",0
