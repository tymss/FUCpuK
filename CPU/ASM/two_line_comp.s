NOP
NOP
NOP
NOP

START:

  LI R4 0X001E
  LI R1 0X0002;COLOR1
  LI R2 0X0003;COLOR2
NEXT_ROW:
  ADDIU R4 0XFFFF
  LI R0 0X0050
  NEXT_COL:
    ADDIU R0 0XFFFE

    ;POS
    SLL R5 R4 0X0000
    OR R5 R0
    LI R6 0X00BF
    SLL R6 R6 0X0000
    ADDIU R6 0X000A
    SW R6 R5 0X0000
    ;DATA
    LI R6 0X00BF
    SLL R6 R6 0X0000
    ADDIU R6 0X000D
    SW R6 R1 0X0000

    ;POS
    LI R3 0X0000
    ADDIU3 R0 R3 0X0001
    SLL R5 R4 0X0000
    OR R5 R3
    LI R6 0X00BF
    SLL R6 R6 0X0000
    ADDIU R6 0X000A
    SW R6 R5 0X0000
    ;DATA
    LI R6 0X00BF
    SLL R6 R6 0X0000
    ADDIU R6 0X000D
    SW R6 R2 0X0000

    NOP
    BNEZ R0 NEXT_COL
    NOP
  NOP
  BNEZ R4 NEXT_ROW
  NOP

LOOP:
NOP
B LOOP
NOP
