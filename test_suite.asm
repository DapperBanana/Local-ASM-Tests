
; Program to calculate the area of a trapezoid
; Input: Base1, Base2, Height
; Output: Area of trapezoid

; Define memory locations for storing input values
Base1    = $fb  ; Base1 of trapezoid
Base2    = $fc  ; Base2 of trapezoid
Height   = $fd  ; Height of trapezoid
Area     = $fe  ; Area of trapezoid

          .org $0200
start     LDX #Base1    ; Load address of Base1
          LDY #Base2    ; Load address of Base2

          ; Input Base1 and Base2
          LDA Base1,X   ; Load Base1 into accumulator
          STA Base1     ; Store Base1
          LDA Base2,Y   ; Load Base2 into accumulator
          STA Base2     ; Store Base2

          ; Input Height
          LDX #Height   ; Load address of Height
          LDA Height,X   ; Load Height into accumulator
          STA Height     ; Store Height

          ; Calculate Area of trapezoid
          LDA Base1     ; Load Base1
          CLC           ; Clear carry
          ADC Base2     ; Add Base2
          STA Area      ; Store sum of Base1 and Base2
          LDA Area      ; Load sum of Base1 and Base2
          ADC Area      ; Add sum of Base1 and Base2 to area of trapezoid
          ADC Area,X    ; Add Height to area of trapezoid
          STA Area      ; Store the final result in Area

          ; Output Area of trapezoid
          LDX #Area     ; Load address of Area
          LDA Area,X    ; Load Area into accumulator
          STA $FF       ; Store the result in $FF  

end       JMP end
          .end
