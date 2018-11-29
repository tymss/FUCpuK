NOP
NOP
NOP
NOP

START:
  LI R3 0
NEXT_ROW:
  LI R0 0X001D
  ADDIU R3 1
  NEXT_COL:
    LI R1 0X004F
    ;FOR ROW R0, COL R1
    LI R2 1
    ADDIU R3 0XFFFF
    AND R2 R3
    ;R2 = 0 => BLACK
    ;R2 = 1 => WHITE

    ;GPUPOS
    SLL R4 R0 0 ;R4 IS POS HIGH 8 DIGIT
    LI R5 0X00FF
    AND R5 R1 ;R5 IS POS LOW 8 DIGIT
    OR R4 R5  ;R4 IS POS FULL
    ;R6 IS 0XBF0A
    LI R6 0X00BF
    SLL R6 R6 0
    ADDIU R6 0X0A
    ;SAVE TO 0XBF0A
    SW R6 R4 0

    ;GPUDATA
    LI R6 0X00BF
    SLL R6 R6 0
    ADDIU R6 0X0D
    ;SAVE TO 0XBF0D
    SW R6 R2 0

    ADDIU R1 0XFFFF
    NOP
    BNEZ R1 NEXT_COL
    NOP

  ADDIU R0 0XFFFF
  NOP
  BNEZ R0 NEXT_ROW
  NOP
  B START
  NOP
  