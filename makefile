BCC	= CC
AS	= has
LK	= hlk

HEAP	= 65536
STACK	= 65536

CCFLAGS	=  /h$(HEAP) /s$(STACK)
ASFLAGS	= -m68000
LKFLAGS	= 
LIBS	= 
OBJS	= sysroot.o keepchk.o
PROGRAM	= sysroot.x

$(PROGRAM)	: $(OBJS)
	$(LK) $(LKFLAGS) -o $(PROGRAM) $^ $(LIBS)

sysroot.o:		sysroot.has	keeped.has
	$(AS) $(ASFLAGS) $<

keepchk.o:		keepchk.s
	$(AS) $(ASFLAGS) $<

