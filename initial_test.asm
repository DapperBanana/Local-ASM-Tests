
* Binary Search Program in 6502 Assembly

* Define the sorted list (array) as data
.data
list:   .byte   10, 20, 30, 40, 50, 60, 70, 80, 90, 100
size:   .byte   10

* Define the variables used in the binary search algorithm
start:  .byte   0
end:    .byte   0
mid:    .byte   0
target: .byte   70

* Start of the program
.text
* Initialize variables
        lda     #0
        sta     start
        lda     size
        sta     end

* Binary search algorithm
loop:   lda     start
        clc
        lda     end
        adc     start
        lsr
        sta     mid

        lda     mid
        asl
        tax
        lda     list, x
        cmp     target
        beq     found
        bcc     check_end

        lda     mid
        sta     end
        bcc     loop

check_end:
        lda     mid
        sta     start
        inc     start
        bcc     loop

found:  lda     target
        jsr     print_number
        rts

* Subroutine to print the result
print_number:
        lda     #0
        sta     $fd
loop1:  ldx     $fd
        lda     target
        tax
        lda     #10
        jsr     divide
        lda     remainder
        sta     $fb, x
        lda     quotient
        sta     target
        lda     quotient
        beq     print
        jmp     loop1

print:  lda     $fb
        jsr     print_digit
        dex
        bpl     print
        rts

print_digit:
        lda     #$30
        clc
        adc     target
        sta     target
        lda     $ff
        jsr     $ffd2
        rts

divide: sta     quotient
        sta     temp1
        sta     temp2
        lda     #$00
loop2:  clc
        adc     #$01
        cmp     temp1
        ldx     #$00
        bcc     loop2
        sec
        sbc     temp1
        inx
        dex
        lda     #$00
loop3:  adc     temp2
        cmp     temp1
        bcc     done
        dec     temp2
        inx
        bcs     loop3
done:   sta     temp1
        lda     temp2
        sta     remainder
        lda     #$00
        sta     quotient
        rts

* End of program
.end
