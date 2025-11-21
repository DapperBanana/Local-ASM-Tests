
  .text
  .org $0200

start:
  LDA #0
  STA area
  LDA #5  ; Length of one side of the tetrahedron
  STA sideLen
  LDA sideLen
  STA baseLen
  JSR calculateBaseArea
  
  LDA #3  ; Number of triangular faces in a tetrahedron
  STA numFaces
  JSR calculateTotalArea

  ; Code to print out the result goes here...

  BRK

calculateBaseArea:
  LDA baseLen
  CLC
  ADC baseLen
  STA baseLen
  LSR
  STA baseLen
  LDA baseLen
  STA height

  LDX #2
calcLoop:
  LDA baseLen
  CLC
  ADC baseLen
  STA baseLen
  DEX
  BNE calcLoop

  LDA baseLen
  ASL
  STA area
  RTS

calculateTotalArea:
  LDX numFaces

calcFaceLoop:
  JSR calculateBaseArea
  LDA area
  CLC
  ADC totalArea
  STA totalArea
  DEX
  BNE calcFaceLoop

  RTS

  .data
totalArea: .byte 0
area: .byte 0
sideLen: .byte 0
baseLen: .byte 0
height: .byte 0
numFaces: .byte 0
