
START equ $c000
ORG START

maze     .db 8,8
         .db ###,###,###,###,###,###,###,###
         .db #S#,# #,#   ,#,   ,#   ,# # ,#E#
         .db ###,###,###,###,###,###,###,###

         ldx #0
         ldy #0
nextrow  lda maze,x
         ldy #0
         inx
nextcol  lda maze,x
         cpx #8
         beq nextrow
         iny
         ldy #0
         beq nextcol

end      brk

         .end
