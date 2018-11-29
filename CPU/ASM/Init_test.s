nop
nop
nop
nop

start:
  li r3 0
next_row:
  li r0 0x001d
  addiu r3 1
  next_col:
    li r1 0x004f
    ;for row r0, col r1
    li r2 1
    addiu r3 0xffff
    and r2 r3
    ;r2 = 0 => black
    ;r2 = 1 => white

    ;GPUpos
    sll r4 r0 0 ;r4 is pos high 8 digit
    li r5 0x00ff
    and r5 r1 ;r5 is pos low 8 digit
    or r4 r5  ;r4 is pos full
    ;r6 is 0xbf0a
    li r6 0x00bf
    sll r6 r6 0
    addiu r6 0x0a
    ;save to 0xbf0a
    sw r6 r4 0

    ;GPUdata
    li r6 0x00bf
    sll r6 r6 0
    addiu r6 0x0d
    ;save to 0xbf0d
    sw r6 r2 0

    addiu r1 0xffff
    nop
    bnez r1 next_col
    nop

  addiu r0 0xffff
  nop
  bnez r0 next_row
  nop
  b start
  nop
