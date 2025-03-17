
; Queue Data Structure Implementation
; Using 6502 Assembly Language

; Constants
QUEUE_SIZE = 5

; Define Stack Pointer
STACKPTR = $FF

; Memory Map
QUEUE_START = $0200
QUEUE_END = QUEUE_START + QUEUE_SIZE

; Define Queue Pointers
; Front pointer points to the front of the queue
; Rear pointer points to the rear of the queue
FRONT_PTR = $00
REAR_PTR = $01

; Start of program
        ORG $0200

START   LDA #$FF
        STA STACKPTR

        LDA #$00
        STA FRONT_PTR
        STA REAR_PTR

        ; Initialize Queue
        LDX #$00
INIT    CPX #QUEUE_SIZE
        BEQ MAIN

        STA QUEUE_START,X
        INX
        JMP INIT

MAIN    ; Enqueue Data
        LDA #10
        JSR ENQUEUE

        LDA #20
        JSR ENQUEUE

        LDA #30
        JSR ENQUEUE

        ; Dequeue Data
        JSR DEQUEUE

        ; Print Queue Data
        JSR PRINT_QUEUE

        ; End of program
        BRK

ENQUEUE LDA REAR_PTR
        CLC
        ADC #1
        CMP #QUEUE_END
        BNE NEXT

        LDA #QUEUE_START
NEXT    STA REAR_PTR

        STA (REAR_PTR),Y
        RTS

DEQUEUE LDA FRONT_PTR
        STA (FRONT_PTR),Y
        INY

        CLC
        ADC #1
        CMP #QUEUE_END
        BNE NEXTD

        LDA #QUEUE_START
NEXTD   STA FRONT_PTR
        RTS

PRINT_QUEUE LDX #$00
PRINT_LOOP
        LDA QUEUE_START,X
        JSR PRINT_HEX
        
        INX
        CPX REAR_PTR
        BEQ END_PRINT

        JMP PRINT_LOOP

END_PRINT
        RTS

PRINT_HEX
        PHA

        LSR A
        LSR A
        LSR A
        LSR A
        AND #$0F
        CMP #$0A
        BCC PRINT_DIGIT
        ADC #$07

PRINT_DIGIT
        ADC #$30
        JSR $FFD2

        PLA
        RTS

        ; Pad Remaining Space with Zeros
        LDA #$30
        JSR $FFD2
        RTS
