NOP
NOP
NOP
NOP

;R0 keyboard data
;R1 counter of row
;R2 counter of col
;R3
;R4
;R5 VGA pos
;R6 0XBF0E 0XBF0A 0XBF0D
;R7 VGA data
START:
LI R2 0X0000
KEYBOARD_GET:
LI R6 0X00BF
SLL R6 R6 0X0000
ADDIU R6 0X000E
  GET:
  LW R6 R0 0X0000
  NOP
  BEQZ R0 GET
  NOP

LI R6 0X00BF
SLL R6 R6 0X0000
ADDIU R6 0X000A
SW R6 R2 0X0000

LI R6 0X00BF
SLL R6 R6 0X0000
ADDIU R6 0X000D
SW R6 R0 0X0000

ADDIU R2 0X0001
NOP
B KEYBOARD_GET
NOP
